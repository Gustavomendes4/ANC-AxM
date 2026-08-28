// =================================================================
// anc_driver.svh - ANC UVM driver
//
// Maps anc_transaction onto the ANC.v input pins:
//     audio_sample   -> x_in
//     desired_sample -> dn
//     mi             -> mi   (project constant, a driver field)
//
// Reading DUT outputs is the monitor's job, not this driver's.
// ================================================================
class anc_driver extends uvm_driver #(anc_transaction);
  `uvm_component_utils(anc_driver)

  virtual anc_if vif;

  logic [ANC_N-1:0] mi = 16'h0CCC;

  // 1 = null cycle when no item is ready (recommended).
  // 0 = blocking get_next_item, which holds the previous sample on the pins.
  bit               idle_on_starvation = 1;

  // ---------------- counters -------------------------------
  protected int unsigned sample_idx     = 0;
  protected int unsigned idle_total     = 0;
  protected int unsigned idle_bursts    = 0;
  protected int unsigned idle_pending   = 0;   // burst in progress
  protected int unsigned reset_count    = 0;
  protected bit          item_in_flight = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual anc_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "virtual anc_if not found in config_db (key: vif)")
  endfunction

  // -----------------------------------------------------------
  task run_phase(uvm_phase phase);
    park_pins();

    forever begin
      if (vif.reset !== 1'b0) begin
        `uvm_info(get_type_name(), "reset asserted - driver parked", UVM_MEDIUM)
        wait (vif.reset === 1'b0);
        `uvm_info(get_type_name(), "reset released - driver active", UVM_MEDIUM)
        @(vif.drv_cb);            // align with the first post-reset cycle
      end

      fork
        begin : active      drive_loop();          end
        begin : reset_watch @(posedge vif.reset);  end
      join_any
      disable fork;

      if (vif.reset === 1'b1) handle_reset();
    end
  endtask

  // --------------------------------------------------------------
  protected task drive_loop();
    anc_transaction item;
    forever begin
      if (idle_on_starvation) begin
        seq_item_port.try_next_item(item);
        if (item == null) begin
          drive_idle_cycle();     // consumes a clock -> no zero-time spin
          idle_total++;
          if (idle_pending == 0) idle_bursts++;
          idle_pending++;
          continue;
        end
      end
      else begin
        seq_item_port.get_next_item(item);
      end

      item_in_flight = 1;
      drive_item(item);
      item_in_flight = 0;
      seq_item_port.item_done();  // release the sequencer for the next cycle
    end
  endtask

  // Drives one sample. Returns right after the edge where the values were
  // applied, which is what allows one sample per cycle back-to-back.
  protected task drive_item(anc_transaction item);
    @(vif.drv_cb);
    vif.drv_cb.x_in <= item.audio_sample;
    vif.drv_cb.dn   <= item.desired_sample;
    vif.drv_cb.mi   <= mi;

    `uvm_info(get_type_name(), $sformatf(
      "DRV [%0d] x=%0.6f(0x%0h) d=%0.6f(0x%0h) mu=%0.6f%s",
      sample_idx,
      anc_dut2real(item.audio_sample),   item.audio_sample,
      anc_dut2real(item.desired_sample), item.desired_sample,
      anc_dut2real(mi),
      (idle_pending > 0) ? $sformatf(" <%0d null cycles before>", idle_pending) : ""),
      UVM_HIGH)

    sample_idx++;
    idle_pending = 0;
  endtask

  // One cycle with null input. mi is held: it is configuration, not a sample.
  protected task drive_idle_cycle();
    @(vif.drv_cb);
    vif.drv_cb.x_in <= '0;
    vif.drv_cb.dn   <= '0;
  endtask

  protected task park_pins();
    vif.drv_cb.x_in <= '0;
    vif.drv_cb.dn   <= '0;
    vif.drv_cb.mi   <= mi;
  endtask

  // ---------------------------------------------------------------------------
  protected task handle_reset();
    reset_count++;
    `uvm_info(get_type_name(), "reset asserted mid-traffic", UVM_LOW)

    // If we were killed inside drive_item, the sequencer is still waiting for
    // item_done() -- without this the sequence hangs forever.
    if (item_in_flight) begin
      seq_item_port.item_done();
      item_in_flight = 0;
    end

    idle_pending = 0;
    park_pins();

  endtask

  // ---------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    // Null cycles AFTER the last sample are harmless: nothing follows them.
    // Only the ones inside the stream matter.
    int unsigned trailing  = idle_pending;
    int unsigned in_stream = idle_total - trailing;
    int unsigned bursts    = idle_bursts - ((trailing > 0) ? 1 : 0);

    `uvm_info(get_type_name(), $sformatf(
      "driver summary: %0d samples driven | %0d null cycles (%0d in-stream over %0d burst(s), %0d trailing) | %0d resets",
      sample_idx, idle_total, in_stream, bursts, trailing, reset_count), UVM_LOW)

    if (in_stream > 0)
      `uvm_warning(get_type_name(), $sformatf(
        "%0d null cycle(s) over %0d burst(s) INSIDE the stream: the sequencer did not keep up and null samples entered the LMS. That shifts the Ro[] delay line and invalidates any comparison against the model.",
        in_stream, bursts))
  endfunction

endclass : anc_driver

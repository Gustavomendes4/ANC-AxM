// =============================================================================
// tb_top.sv - UVM simulation top for the ANC driver
// =============================================================================
`timescale 1ns/1ps

module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import anc_pkg::*;

  localparam int  N          = 16;
  localparam int  F          = 14;
  localparam time CLK_PERIOD = 20ns;   // 50 MHz

  logic clock = 1'b0;
  always #(CLK_PERIOD/2) clock = ~clock;

  anc_if #(.N(N)) intf (.clock(clock));

  ANC #(.N(N), .F(F)) dut (
    .clock (clock),
    .reset (intf.reset),
    .x_in  (intf.x_in),
    .dn    (intf.dn),
    .mi    (intf.mi),
    .en    (intf.en),
    .out   (intf.out)
  );

  // A single process drives reset, to avoid two drivers on the same variable.
  // +RESET_AT=<ns> pulses reset again mid-traffic, to exercise driver recovery.
  initial begin
    int unsigned rst_at;

    intf.reset = 1'b1;
    repeat (5) @(posedge clock);
    intf.reset = 1'b0;

    if ($value$plusargs("RESET_AT=%d", rst_at)) begin
      #(rst_at * 1ns);
      @(posedge clock);
      intf.reset = 1'b1;
      $display("[tb_top] reset asserted at %0t", $time);
      repeat (3) @(posedge clock);
      intf.reset = 1'b0;
      $display("[tb_top] reset released at %0t", $time);
    end
  end

  initial begin
    // "*": with "uvm_test_top" the driver (uvm_test_top.drv) can't find the vif.
    uvm_config_db#(virtual anc_if)::set(null, "*", "vif", intf);
    run_test();   // test comes from +UVM_TESTNAME
  end

  initial begin
    if ($test$plusargs("FSDB")) begin
      $fsdbDumpfile("tb_top.fsdb");
      $fsdbDumpvars(0, tb_top);
    end
  end

  // Per-sample trace: +DUMP=<file> writes one CSV line per cycle out of reset,
  // +DUMP_W adds the 10 W coefficients.
  //
  // Sampled on the negedge, away from the driver (posedge + 1ns) and the RTL
  // registers (posedge). out/en/W end up one edge ahead of x_in/dn on the same
  // line: check the alignment (0, 1 or 2 samples) before comparing with the model.
  //
  // Raw two's complement words (real = raw / 2**F); %f would hide 1 LSB
  // differences. W[k] is the LMS_Direct_10taps array - the approximate LMS uses
  // W1..W10 and needs a change here.
  int trace_fd = 0;

  initial begin
    string       fname;
    bit          with_w;
    int unsigned idx = 0;

    if ($value$plusargs("DUMP=%s", fname)) begin
      with_w   = $test$plusargs("DUMP_W");
      trace_fd = $fopen(fname, "w");

      if (trace_fd == 0) begin
        $display("[tb_top] FATAL: cannot open '%s' for writing", fname);
        $finish;
      end

      $fwrite(trace_fd, "# anc rtl trace\n");
      $fwrite(trace_fd, "# N=%0d F=%0d\n", N, F);
      $fwrite(trace_fd, "# raw two's complement words; real = raw / 2**F\n");
      $fwrite(trace_fd, "# out/en/w are one edge ahead of x_in/dn - see tb_top.sv\n");
      $fwrite(trace_fd, "idx,x_in,dn,out,en");
      if (with_w)
        for (int k = 0; k < 10; k++) $fwrite(trace_fd, ",w%0d", k);
      $fwrite(trace_fd, "\n");

      forever begin
        @(negedge clock);
        if (intf.reset === 1'b0) begin
          $fwrite(trace_fd, "%0d,%0d,%0d,%0d,%0d", idx,
                  $signed(intf.x_in), $signed(intf.dn),
                  $signed(intf.out),  $signed(intf.en));
          if (with_w)
            for (int k = 0; k < 10; k++)
              $fwrite(trace_fd, ",%0d", $signed(dut.W_filter.W[k]));
          $fwrite(trace_fd, "\n");
          idx++;
        end
      end
    end
  end

  final begin
    if (trace_fd != 0) $fclose(trace_fd);
  end

endmodule : tb_top

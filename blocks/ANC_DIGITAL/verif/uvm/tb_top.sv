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
    uvm_config_db#(virtual anc_if)::set(null, "uvm_test_top", "vif", intf);
    run_test();   // test comes from +UVM_TESTNAME
  end

  initial begin
    if ($test$plusargs("FSDB")) begin
      $fsdbDumpfile("tb_top.fsdb");
      $fsdbDumpvars(0, tb_top);
    end
  end

endmodule : tb_top

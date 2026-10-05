// =============================================================================
// anc_if.sv - ANC DUT pin interface
// =============================================================================
`timescale 1ns/1ps

interface anc_if #(parameter int N = 16) (input logic clock);

  logic         reset;
  logic [N-1:0] x_in;   // reference sample  x(n)
  logic [N-1:0] dn;     // desired signal    d(n) = P(x(n))
  logic [N-1:0] mi;     // adaptation step   mu
  logic [N-1:0] en;     // error (combinational: d + S(y))
  logic [N-1:0] out;    // W filter output (registered)

  // ---------------------------------------------------------------------------
  // output #1ns: the RTL registers use blocking assignment on posedge
  // (always @(posedge clock) S = A). Driving exactly on the edge would race
  // with them.
  // ---------------------------------------------------------------------------
  clocking drv_cb @(posedge clock);
    default input #1step output #1ns;
    output x_in, dn, mi;
    input  reset, en, out;
  endclocking

  clocking mon_cb @(posedge clock);
    default input #1step;
    input reset, x_in, dn, mi, en, out;
  endclocking

  modport DRV (clocking drv_cb, input clock);
  modport MON (clocking mon_cb, input clock);

endinterface : anc_if

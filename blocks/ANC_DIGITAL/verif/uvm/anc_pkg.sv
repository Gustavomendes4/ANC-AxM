// anc_pkg.sv - UVM package for the ANC_DIGITAL driver

`timescale 1ns/1ps

package anc_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  parameter int ANC_N = 16;   // datapath width
  parameter int ANC_F = 14;   // fractional bits

  parameter int ANC_MAX = (1 << (ANC_N-1)) - 1;   //  32767
  parameter int ANC_MIN = -(1 << (ANC_N-1));

  // DUT-width two's complement value -> real, for logging
  function automatic real anc_dut2real(logic [ANC_N-1:0] v);
    return real'($signed(v)) / real'(1 << ANC_F);
  endfunction

  function automatic logic [ANC_N-1:0] anc_raw2dut(int raw, ref bit clipped);
    if (raw > ANC_MAX) begin clipped = 1; return ANC_N'(ANC_MAX); end
    if (raw < ANC_MIN) begin clipped = 1; return ANC_N'(ANC_MIN); end
    return ANC_N'(raw);
  endfunction

  // verif/
  `include "anc_transaction.sv"
  `include "anc_sequencer.sv"
  `include "anc_sequence.sv"   // calls the C++ model as model::<fn>, no import

  `include "anc_driver.svh"

  `include "anc_wav_sequence.svh"
  `include "anc_base_test.svh"
  `include "anc_wav_test.svh"

endpackage : anc_pkg

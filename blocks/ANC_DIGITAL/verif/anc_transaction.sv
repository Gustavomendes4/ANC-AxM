`ifndef ANC_TRANSACTION_SV
`define ANC_TRANSACTION_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class anc_transaction extends uvm_sequence_item;
  // Amostra de audio de 16 bits padronizada
  rand logic [15:0] audio_sample;    // -> x_in
  // dn = P(x). O ANC calcula e = dn + S(y); com dn em zero o LMS nao adapta.
  rand logic [15:0] desired_sample;  // -> dn

  `uvm_object_utils_begin(anc_transaction)
    `uvm_field_int(audio_sample,   UVM_ALL_ON)
    `uvm_field_int(desired_sample, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "anc_transaction");
    super.new(name);
  endfunction
endclass

`endif

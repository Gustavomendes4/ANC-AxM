`ifndef ANC_TRANSACTION_SV
`define ANC_TRANSACTION_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class anc_transaction extends uvm_sequence_item;
  // Amostra de áudio de 16 bits padronizada
  rand logic [15:0] audio_sample;

  `uvm_object_utils_begin(anc_transaction)
    `uvm_field_int(audio_sample, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "anc_transaction");
    super.new(name);
  endfunction
endclass

`endif

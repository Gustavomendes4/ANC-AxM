`ifndef ANC_SEQUENCER_SV
`define ANC_SEQUENCER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class anc_sequencer extends uvm_sequencer #(anc_transaction);
  `uvm_component_utils(anc_sequencer)

  function new(string name = "anc_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

`endif

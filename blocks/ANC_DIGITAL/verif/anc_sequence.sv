`ifndef ANC_SEQUENCE_SV
`define ANC_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class anc_sequence extends uvm_sequence #(anc_transaction);
  `uvm_object_utils(anc_sequence)

  function new(string name = "anc_sequence");
    super.new(name);
  endfunction

  virtual task body();
    anc_transaction tx;
    
    // Gera 10 amostras aleatórias de 16 bits como teste inicial
    repeat (10) begin
      tx = anc_transaction::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize()); 
      finish_item(tx);
    end
  endtask
endclass

`endif

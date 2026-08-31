`ifndef ANC_SEQUENCE_SV
`define ANC_SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

// Função DPI-C criada pelo Guilherme para puxar o áudio do C++
import "DPI-C" function int ambient_next_sample_fixed();

class anc_sequence extends uvm_sequence #(anc_transaction);
  `uvm_object_utils(anc_sequence)

  function new(string name = "anc_sequence");
    super.new(name);
  endfunction

  virtual task body();
    anc_transaction req;
    int sample_from_cpp;

    // Processa amostra por amostra de áudio (1000 iterações de teste)
    repeat (1000) begin
      req = anc_transaction::type_id::create("req");

      start_item(req);

      // 1. Pega a amostra vinda do Golden Model C++
      sample_from_cpp = ambient_next_sample_fixed();

      // 2. Trata a largura de 16 bits exigida pelo hardware (RTL)
      req.audio_sample = sample_from_cpp[15:0];

      finish_item(req); // Envia a transação ao Driver e aguarda o envio
    end
  endtask
endclass

`endif // ANC_SEQUENCE_SV

`ifndef ANC_SEQUENCE_SV
`define ANC_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// =============================================================================
// anc_sequence.sv - le o audio pelo modelo C++ (DPI, package model) e gera um
// anc_transaction por amostra: x_in <- x(n), dn <- P(x(n)).
// Padrao: 1000 amostras. anc_wav_sequence estende esta classe.
// =============================================================================
class anc_sequence extends uvm_sequence #(anc_transaction);
  `uvm_object_utils(anc_sequence)

  string       wav_file      = "";     // +WAV=<arquivo> sobrescreve
  int unsigned num_samples   = 1000;   // 0 = arquivo inteiro

  // Definido no body(); o anc_base_test usa para dividir a medicao ao meio.
  int unsigned total_samples = 0;
  int unsigned n_driven      = 0;

  protected chandle amb = null;

  function new(string name = "anc_sequence");
    super.new(name);
  endfunction

  // ---------------------------------------------------------------------------
  virtual task body();
    anc_transaction req;
    int             x_raw, d_raw;   // palavras em ponto fixo vindas do modelo
    int unsigned    i;

    configure();
    open_ambient();

    // Processa amostra por amostra de audio
    for (i = 0; i < total_samples; i++) begin
      // 1. Pega a amostra vinda do Golden Model C++
      if (!next_stimulus(x_raw, d_raw)) begin
        `uvm_info(get_type_name(), $sformatf("end of audio at sample %0d", i), UVM_LOW)
        break;
      end

      req = anc_transaction::type_id::create($sformatf("req_%0d", i));

      start_item(req);
      // 2. Trata a largura de 16 bits exigida pelo hardware (RTL)
      map_stimulus(req, x_raw, d_raw, i);
      finish_item(req);   // Envia a transacao ao Driver e aguarda o envio

      n_driven++;
    end

    close_ambient();
    report_done();
  endtask

  // ---------------------------------------------------------------------------
  virtual function void configure();
    string arg_s;
    if ($value$plusargs("WAV=%s", arg_s)) wav_file = arg_s;
  endfunction

  // Retorna 0 quando o audio acaba.
  // calculate_error com anc_y = 0 devolve exatamente P(x): o S do modelo so
  // depende das proprias saidas passadas, entao com entrada zero fica em zero.
  // As duas chamadas precisam alternar uma vez por amostra (protocolo do Ambient).
  virtual function bit next_stimulus(output int x_raw, output int d_raw);
    if (!model::ambient_next_sample_fixed(amb, x_raw)) return 0;
    if (!model::ambient_calculate_error_fixed(amb, 0, d_raw)) begin
      `uvm_error(get_type_name(), "ambient_calculate_error_fixed failed")
      return 0;
    end
    return 1;
  endfunction

  // Truncamento simples; anc_wav_sequence troca por saturacao.
  virtual function void map_stimulus(anc_transaction req,
                                     int x_raw, int d_raw, int unsigned idx);
    req.audio_sample   = x_raw[15:0];
    req.desired_sample = d_raw[15:0];
  endfunction

  virtual function void report_done();
    `uvm_info(get_type_name(),
              $sformatf("sequence done: %0d sample(s) driven", n_driven), UVM_LOW)
  endfunction

  // ---------------------------------------------------------------------------
  // O Ambient e um objeto C++: toda chamada usa o chandle de ambient_create().
  protected virtual function void open_ambient();
    int total;

    if (wav_file == "")
      `uvm_fatal(get_type_name(),
                 "no WAV file given - pass +WAV=<file> (make sim UVM=1 UVM_TEST=<test> WAV=<file>)")

    amb = model::ambient_create(wav_file);
    if (amb == null)
      `uvm_fatal(get_type_name(), $sformatf("ambient_create failed for '%s'", wav_file))

    total = model::ambient_num_samples(amb);
    if (total <= 0)
      `uvm_fatal(get_type_name(), $sformatf("WAV '%s' reports %0d samples", wav_file, total))

    total_samples = (num_samples != 0 && num_samples < total) ? num_samples : total;

    `uvm_info(get_type_name(), $sformatf(
      "WAV '%s': %0d sample(s) in file, driving %0d, Q%0d.%0d",
      wav_file, total, total_samples, ANC_N-ANC_F, ANC_F), UVM_LOW)
  endfunction

  protected virtual function void close_ambient();
    if (amb != null) begin
      model::ambient_free(amb);
      amb = null;
    end
  endfunction

endclass : anc_sequence

`endif // ANC_SEQUENCE_SV

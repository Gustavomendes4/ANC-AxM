// =============================================================================
// anc_wav_sequence.svh - anc_sequence para o arquivo WAV inteiro
//   +WAV_SAMPLES=<n>  limita o numero de amostras (padrao: arquivo inteiro)
//   +WAV_SHIFT=<n>    multiplica o estimulo por 2**n
//
// Converte com saturacao em vez de truncar: truncar inverte o sinal quando o
// valor passa de 16 bits. Ao aumentar o ganho G, mi deve cair com G^2.
// =============================================================================
class anc_wav_sequence extends anc_sequence;
  `uvm_object_utils(anc_wav_sequence)

  int unsigned wav_shift = 0;   // o teste pode mudar; plusargs tem prioridade

  int unsigned n_clip = 0;

  function new(string name = "anc_wav_sequence");
    super.new(name);
    num_samples = 0;   // arquivo inteiro
  endfunction

  // ---------------------------------------------------------------------------
  virtual function void configure();
    int unsigned arg_u;
    super.configure();                                            // +WAV=
    if ($value$plusargs("WAV_SAMPLES=%d", arg_u)) num_samples = arg_u;
    if ($value$plusargs("WAV_SHIFT=%d",   arg_u)) wav_shift   = arg_u;
  endfunction

  // ---------------------------------------------------------------------------
  virtual function void map_stimulus(anc_transaction req,
                                     int x_raw, int d_raw, int unsigned idx);
    bit clip = 0;
    int x_s  = x_raw <<< wav_shift;
    int d_s  = d_raw <<< wav_shift;

    req.audio_sample   = anc_raw2dut(x_s, clip);
    req.desired_sample = anc_raw2dut(d_s, clip);

    if (clip) begin
      n_clip++;
      if (n_clip <= 10)
        `uvm_warning(get_type_name(), $sformatf(
          "sample %0d saturated: x_raw=%0d d_raw=%0d (lower WAV_SHIFT)", idx, x_s, d_s))
    end
  endfunction

  // ---------------------------------------------------------------------------
  virtual function void report_done();
    `uvm_info(get_type_name(), $sformatf(
      "sequence done: %0d sample(s) driven, %0d saturated, shift=%0d",
      n_driven, n_clip, wav_shift), UVM_LOW)

    if (n_clip > 0)
      `uvm_warning(get_type_name(), $sformatf(
        "%0d sample(s) saturated at the 16-bit boundary - the DUT did not see the real audio",
        n_clip))
  endfunction

endclass : anc_wav_sequence

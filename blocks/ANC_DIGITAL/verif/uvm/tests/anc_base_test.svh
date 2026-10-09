// =============================================================================
// anc_base_test.svh - sequencer + driver + anc_sequence, com medidor de energia
//
// idle_on_starvation = 0: o ANC nao tem handshake (Ro[] e W[] atualizam a todo
// posedge), entao um ciclo vazio no meio do fluxo desalinha o RTL do modelo.
// =============================================================================
class anc_base_test extends uvm_test;
  `uvm_component_utils(anc_base_test)

  anc_sequencer   sqr;
  anc_driver      drv;
  anc_sequence    seq;
  virtual anc_if  vif;

  // Ciclos apos a ultima amostra, ate ela chegar na saida.
  int unsigned drain_cycles = 32;

  // Medidor de energia: 10*log10(sum(en^2)/sum(dn^2)).
  // Negativo = atenuacao, ~0 dB = LMS nao adapta, positivo = divergencia.
  // Nao compara com o modelo amostra a amostra. verif/samples/outyn_values.txt
  // nao serve de referencia (gerado com F=11 e ganho 2**10).
  protected real         sum_d2    = 0.0;
  protected real         sum_e2    = 0.0;
  protected real         sum_d2_h1 = 0.0;   // 1a metade, para ver a convergencia
  protected real         sum_e2_h1 = 0.0;
  protected int unsigned n_meas    = 0;
  protected bit          h1_done   = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Subclasses trocam a sequence aqui (ver anc_wav_test).
  virtual function anc_sequence create_sequence();
    return anc_sequence::type_id::create("seq");
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual anc_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "virtual anc_if not found in config_db (key: vif)")

    sqr = anc_sequencer::type_id::create("sqr", this);
    drv = anc_driver   ::type_id::create("drv", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    drv.idle_on_starvation = 0;   // ver cabecalho
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "playing audio through the DUT");

    wait (vif.reset === 1'b0);

    seq = create_sequence();

    fork
      begin : meter  measure_loop();  end
      begin : play
        seq.start(sqr);
        repeat (drain_cycles) @(posedge vif.clock);
      end
    join_any
    disable fork;

    report_cancellation();

    phase.drop_objection(this, "audio finished");
  endtask

  // Amostra dn e en a cada ciclo fora do reset.
  protected task measure_loop();
    real d, e;
    forever begin
      @(vif.mon_cb);
      if (vif.mon_cb.reset === 1'b0) begin
        d = anc_dut2real(vif.mon_cb.dn);
        e = anc_dut2real(vif.mon_cb.en);
        sum_d2 += d*d;
        sum_e2 += e*e;
        n_meas++;

        // total_samples so e conhecido depois que o body() abre o WAV.
        if (!h1_done && seq != null && seq.total_samples != 0 &&
            n_meas >= (seq.total_samples / 2)) begin
          sum_d2_h1 = sum_d2;
          sum_e2_h1 = sum_e2;
          h1_done   = 1;
        end
      end
    end
  endtask

  protected function void report_cancellation();
    real db_all, db_h1, db_h2;
    real d2_h2, e2_h2;

    if (n_meas == 0 || sum_d2 == 0.0) begin
      `uvm_error(get_type_name(),
                 "energy meter saw no signal: dn stayed at zero the whole run")
      return;
    end

    if (!h1_done) begin   // execucao curta demais para dividir
      sum_d2_h1 = sum_d2;
      sum_e2_h1 = sum_e2;
    end
    d2_h2  = sum_d2 - sum_d2_h1;
    e2_h2  = sum_e2 - sum_e2_h1;

    db_all = 10.0 * $log10(sum_e2 / sum_d2);
    db_h1  = (sum_d2_h1 > 0.0) ? 10.0 * $log10(sum_e2_h1 / sum_d2_h1) : 0.0;
    db_h2  = (d2_h2    > 0.0) ? 10.0 * $log10(e2_h2    / d2_h2)       : 0.0;

    `uvm_info(get_type_name(), $sformatf(
      "cancellation over %0d cycle(s): %0.2f dB  (1st half %0.2f dB -> 2nd half %0.2f dB)",
      n_meas, db_all, db_h1, db_h2), UVM_LOW)

    if (db_all > -0.5)
      `uvm_warning(get_type_name(), $sformatf(
        "no attenuation (%0.2f dB): the LMS is not adapting. Check that dn is non-zero on the pins and that mi is sane.",
        db_all))
    if (db_h2 > db_h1 + 1.0)
      `uvm_warning(get_type_name(), $sformatf(
        "error energy GREW over the run (%0.2f -> %0.2f dB): mi is probably too large for this input scale.",
        db_h1, db_h2))
  endfunction

endclass : anc_base_test

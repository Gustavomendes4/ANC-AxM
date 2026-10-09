// anc_wav_test.svh - anc_base_test com anc_wav_sequence (arquivo WAV inteiro)
class anc_wav_test extends anc_base_test;
  `uvm_component_utils(anc_wav_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function anc_sequence create_sequence();
    return anc_wav_sequence::type_id::create("seq");
  endfunction

endclass : anc_wav_test

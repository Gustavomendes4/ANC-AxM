package model;
  // import "DPI-C" function chandle ambient_create(string wavfile, int decimal_bits);
  // import "DPI-C" function void ambient_free(chandle ambient);
  // import "DPI-C" function int ambient_num_samples(chandle ambient);
  // import "DPI-C" function int ambient_next_sample(chandle ambient, output real sample);
  // import "DPI-C" function int ambient_next_sample_fixed(chandle ambient, output int sample);
  // import "DPI-C" function int ambient_calculate_error(chandle ambient, real anc_y, output real sample);
  // import "DPI-C" function int ambient_calculate_error_fixed(chandle ambient, int anc_y, output int sample);


import "DPI-C" function chandle ambient_create(string wavfile);
import "DPI-C" function void ambient_free(chandle ambient);
import "DPI-C" function int ambient_num_samples(chandle ambient);
import "DPI-C" function int ambient_next_sample(chandle ambient, output real sample) ;
import "DPI-C" function int ambient_next_sample_fixed(chandle ambient, output int sample);
import "DPI-C" function int ambient_calculate_error(chandle ambient, real anc_y, output real err_n);
import "DPI-C" function int ambient_calculate_error_fixed(chandle ambient, int anc_y, output int err_n);
import "DPI-C" function chandle fxlms_create(int w_order, int sh_order, int w_mu, int sh_mu);
import "DPI-C" function void fxlms_free(chandle fxlms);
import "DPI-C" function void fxlms_w_process(chandle fxlms, int sample, output int y);
import "DPI-C" function void fxlms_w_learn(chandle fxlms, int err_n);
import "DPI-C" function void fxlms_sh_process(chandle fxlms, int sample, output int y);
import "DPI-C" function void fxlms_sh_learn(chandle fxlms, int err_n);

endpackage

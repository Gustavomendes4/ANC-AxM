package model;

/// Create the ambient
import "DPI-C" function chandle ambient_create(string wavfile);
/// Destroy the ambient
import "DPI-C" function void ambient_free(chandle ambient);


/// Returns the number of samples in the audio file
import "DPI-C" function int ambient_num_samples(chandle ambient);

/// Returns the next sample. The error of the last sample must already have
/// been processed.
import "DPI-C" function int ambient_next_sample(chandle ambient, output real sample);
/// Returns the next sample in fixed point. The error of the last sample must already have
/// been processed.
import "DPI-C" function int ambient_next_sample_fixed(chandle ambient, output int sample);

/// Calculates the last sample's error. Must be called only once after the
/// last sample was processed by the models.
import "DPI-C" function int ambient_calculate_error(chandle ambient, real anc_y, output real err_n);
/// Calculates the last sample's error in fixed point. Must be called only once after the
/// last sample was processed by the models.
import "DPI-C" function int ambient_calculate_error_fixed(chandle ambient, int anc_y, output int err_n);

/// Create the golden model
import "DPI-C" function chandle fxlms_create(int w_order, int sh_order, int w_mu, int sh_mu);
/// Destroy the golden model
import "DPI-C" function void fxlms_free(chandle fxlms);

import "DPI-C" function void fxlms_w_process(chandle fxlms, int sample, output int y);
import "DPI-C" function void fxlms_w_learn(chandle fxlms, int err_n);

import "DPI-C" function void fxlms_sh_process(chandle fxlms, int sample, output int y);
import "DPI-C" function void fxlms_sh_learn(chandle fxlms, int err_n);

endpackage

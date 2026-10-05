#include "anc.cpp"

#ifndef MODEL_F
#error "MODEL_F should be defined"
#endif

using modelf = fixed<MODEL_F>;

extern "C" {

void *ambient_create(const char *wavfile) {
  try {
    return new Ambient(wavfile);
  } catch (const char *e) {
    std::cerr << "ambient error: " << e << "\n";
    return NULL;
  }
}

void ambient_free(void *ambient) { delete static_cast<Ambient *>(ambient); }

int ambient_num_samples(void *ambient) {
  auto amb = static_cast<Ambient *>(ambient);
  return amb->num_samples();
}

int ambient_next_sample(void *ambient, double *sample) {
  auto amb = static_cast<Ambient *>(ambient);
  try {
    *sample = amb->next_sample();
    return true;
  } catch (const char *e) {
    std::cerr << "ambient error: " << e << "\n";
    return false;
  }
}

int ambient_next_sample_fixed(void *ambient, int32_t *sample) {
  auto amb = static_cast<Ambient *>(ambient);
  try {
    auto smp = amb->next_sample_fixed<MODEL_F>();
    *sample = smp.raw_value();
    return true;
  } catch (const char *e) {
    std::cerr << "ambient error: " << e << "\n";
    return false;
  }
}

int ambient_calculate_error(void *ambient, double anc_y, double *err_n) {
  auto amb = static_cast<Ambient *>(ambient);
  try {
    *err_n = amb->calculate_error(anc_y);
    return true;
  } catch (const char *e) {
    std::cerr << "ambient error: " << e << "\n";
    return false;
  }
}

int ambient_calculate_error_fixed(void *ambient, int32_t anc_y,
                                  int32_t *err_n) {
  auto amb = static_cast<Ambient *>(ambient);
  try {
    modelf y = modelf::from_raw_value(anc_y);
    *err_n = amb->calculate_error_fixed(y).raw_value();
    return true;
  } catch (const char *e) {
    std::cerr << "ambient error: " << e << "\n";
    return false;
  }
}

void *fxlms_create(int w_order, int sh_order, int32_t w_mu, int32_t sh_mu) {
  auto wmu = modelf::from_raw_value(w_mu);
  auto shmu = modelf::from_raw_value(sh_mu);
  return new FxLMS<modelf>(w_order, sh_order, wmu, shmu);
}
void fxlms_free(void *fxlms) { delete static_cast<FxLMS<modelf> *>(fxlms); }

void fxlms_w_process(void *fxlms, int sample, int *y) {
  auto lms = static_cast<FxLMS<modelf> *>(fxlms);
  *y = lms->w_process(modelf::from_raw_value(sample)).raw_value();
}
void fxlms_w_learn(void *fxlms, int err_n) {
  auto lms = static_cast<FxLMS<modelf> *>(fxlms);
  lms->w_learn(modelf::from_raw_value(err_n));
}

void fxlms_sh_process(void *fxlms, int sample, int *y) {
  auto lms = static_cast<FxLMS<modelf> *>(fxlms);
  *y = lms->sh_process(modelf::from_raw_value(sample)).raw_value();
}

void fxlms_sh_learn(void *fxlms, int err_n) {
  auto lms = static_cast<FxLMS<modelf> *>(fxlms);
  lms->sh_learn(modelf::from_raw_value(err_n));
}
}

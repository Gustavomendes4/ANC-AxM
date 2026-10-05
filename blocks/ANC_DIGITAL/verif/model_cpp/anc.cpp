#include <iostream>
#include <random>
#include <stdint.h>
#include <stdio.h>
#include <vector>
#include <initializer_list>

#include "AudioFile.h"
#include "fpm/fixed.hpp"

template <unsigned int frac> using fixed = fpm::fixed<int32_t, int64_t, frac>;

template <typename scalar> class Circular {
private:
  int istart;
  std::vector<scalar> buf;

public:
  Circular(int size) {
    istart = 1;
    buf.resize(size);
  }
  scalar get(int i) { return buf.at((istart + i) % buf.size()); }
  void add(scalar item) {
    --istart;
    if (istart < 0) {
      istart = buf.size() - 1;
    }
    buf.at(istart) = item;
  }

  void clear() {

    for (size_t i = 0; i < buf.size(); ++i) {
      buf.at(i) = 0;
    }
  }
  int size() { return buf.size(); }

  void print() {
    for (int i = 0; i < size(); ++i) {
      std::cout << get(i) << " ";
    }
    std::cout << '\n';
  }
};

class CombFilter {
private:
  Circular<double> buffer;

public:
  CombFilter() : buffer(2) {}
  double process(double sample) {
    double y = sample - 0.5 * buffer.get(1) - 0.3 * buffer.get(0);
    buffer.add(y);
    return y;
  }
};

template <typename scalar> class Filter {
protected:
  Circular<scalar> buffer;
  std::vector<scalar> coefs;

public:
  Filter(std::vector<scalar> &weights) : coefs(weights), buffer(coefs.size()) {}
  Filter(std::initializer_list<scalar> weights) : buffer(weights.size()) {
    coefs.insert(coefs.end(), weights.begin(), weights.end());
  }
  Filter(int order) : buffer(order) { coefs.resize(order); }

  scalar process(scalar sample) {
    buffer.add(sample);

    scalar out{0};
    for (int i = 0; i < order(); ++i) {
      out += coefs[i] * buffer.get(i);
    }
    return out;
  }
  void set(int i, scalar weight) { this->coefs.at(i) = weight; }
  void clear_buffer() { buffer.clear(); }
  int order() { return coefs.size(); }
  void print_coefs() {
    for (auto w : coefs) {
      std::cout << w << " ";
    }
    std::cout << '\n';
  }
};

template <typename scalar> class WFilter : public Filter<scalar> {
public:
  WFilter(int order) : Filter<scalar>(order) {}

  void learn(scalar mu, scalar e_n, Circular<scalar> &fx) {
    for (int i = 0; i < this->order(); ++i) {
      this->coefs.at(i) += mu * e_n * fx.get(i);
    }
  }
};

template <typename scalar> class SFilter : public Filter<scalar> {
public:
  SFilter(int order) : Filter<scalar>(order) {}

  void learn(scalar mu, scalar e_n) {
    for (int i = 0; i < this->order(); ++i) {
      this->coefs.at(i) += mu * e_n * this->buffer.get(i);
    }
  }
};

class WhiteNoise {
private:
  std::minstd_rand rng;
  std::uniform_real_distribution<double> dist;

public:
  WhiteNoise(int seed) : rng(seed), dist(-0.2, 0.2) {}
  double next() { return dist(rng); }
};

template <typename scalar> class FxLMS {
private:
  Circular<scalar> fx; // filtered x
  WFilter<scalar> w;   // approximates P(x)
  SFilter<scalar> sh;  // approximates S(x)
  scalar w_mu;
  scalar sh_mu;

public:
  FxLMS(int w_order, int sh_order, scalar w_mu, scalar sh_mu)
      : fx(w_order), w(w_order), sh(sh_order), w_mu(w_mu), sh_mu(sh_mu) {}

  scalar w_process(scalar sample) {
    scalar y = w.process(sample);

    scalar fx_sample = sh.process(sample);
    fx.add(fx_sample);

    return -y;
  }
  void w_learn(scalar error_sample) { w.learn(w_mu, error_sample, fx); }

  scalar sh_process(scalar sample) { return sh.process(sample); }
  void sh_learn(scalar error_sample) { sh.learn(sh_mu, error_sample); }

  void go_online() { sh.clear_buffer(); }
};

void save_array(const char *filename, double *array, int size) {
  FILE *f = fopen(filename, "w");
  if (!f) {
    throw "failed to open file";
  }
  for (int i = 0; i < size; ++i) {
    fprintf(f, "%.12f\n", array[i]);
  }
  fclose(f);
}

class Ambient {
private:
  Filter<double> P;
  CombFilter S;
  AudioFile<double> wav_in;
  int wav_idx = -1;
  bool ready_next = true;

public:
  Ambient(const char *wavfile) : P({1.0, 0.5, 0.25, 0.125, 0.01}) {
    if (!wav_in.load(wavfile)) {
      throw "error opening WAV file";
    }
  }

  /// Gets the number of samples of the wav file
  int num_samples() { return wav_in.getNumSamplesPerChannel(); }
  int bit_depth() { return wav_in.getBitDepth(); }
  int sample_rate() { return wav_in.getSampleRate(); }

  /// Returns the current sample.
  double curr_sample() {
    double x_in;
    if (wav_in.isStereo()) {
      x_in = (wav_in.samples.at(0).at(wav_idx) +
              wav_in.samples.at(1).at(wav_idx)) /
             2.0;
    } else {
      x_in = wav_in.samples.at(0).at(wav_idx);
    }
    return x_in;
  }
  /// Returns the fixed point representation of `curr_sample()`
  // fixed curr_sample_fixed() { return fixed{curr_sample()}; }
  template <unsigned int frac> fixed<frac> curr_sample_fixed() {
    return fixed<frac>{curr_sample()};
  }

  /// Advances the audio cursor and return the next sample
  /// Throws if `calculate_error hasn't been called
  double next_sample() {
    if (!ready_next) {
      throw "can't advance audio cursor without calculating error first";
    }
    ++wav_idx;
    if (wav_idx == num_samples()) {
      throw "end of samples";
    }
    ready_next = false;
    return curr_sample();
  }
  /// Returns the fixed point representation of `next_sample()`
  // fixed next_sample_fixed() { return fixed{next_sample()}; }
  template <unsigned int frac> fixed<frac> next_sample_fixed() {
    return fixed<frac>{next_sample()};
  }

  /// Calculates the error between the ANC output and P(x)
  double calculate_error(double anc_y) {
    if (ready_next) {
      throw "can't calculate error before getting next sample";
    }
    double P_x = P.process(curr_sample());
    double S_x = S.process(anc_y);
    ready_next = true;
    return S_x + P_x;
  }

  /// Returns the fixed point representation of `calculate_error()`
  template <unsigned int frac>
  fixed<frac> calculate_error_fixed(fixed<frac> anc_y) {
    return fixed<frac>(calculate_error(static_cast<double>(anc_y)));
  }
};

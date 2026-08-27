#include "anc.cpp"
#include <cmath>
#include <fstream>

#define ESTIMATE_S_SAMPLES 44100

int main(int argc, char **argv) {

  if (argc < 2) {
    std::cerr << "wav file name missing" << std::endl;
    return 1;
  }

  std::ifstream w_coefs_txt("w_coefs.txt");
  std::ofstream err_txt("err_cpp.txt");

  Ambient ambient(argv[1]);

  AudioFile<double> out_file;
  out_file.setNumChannels(1);
  out_file.setSampleRate(ambient.sample_rate());
  out_file.setBitDepth(ambient.bit_depth());
  out_file.setNumSamplesPerChannel(ambient.num_samples());

  AudioFile<double>::AudioBuffer anc_buffer;
  AudioFile<double>::AudioBuffer err_buffer;
  anc_buffer.resize(1);
  anc_buffer[0].resize(ambient.num_samples());
  err_buffer.resize(1);
  err_buffer[0].resize(ambient.num_samples());

  // WhiteNoise<double> wn(1);

  // FxLMS
  FxLMS<double> fxlms(10, 10, 0.2, 0.002);

  // ambient filters
  // Filter<double> P({1.0, 0.5, 0.25, 0.125, 0.01});
  // Filter<double> S({1.0, 0.5, -0.3});
  CombFilter S2;

  std::cout << "Estimating S...\n";
  for (int i = 0; i < ESTIMATE_S_SAMPLES; ++i) {
    double sample = 0.5 * std::sin(2 * 3.142 * i * 400 / ESTIMATE_S_SAMPLES);

    double y = fxlms.sh_process(sample);
    double S_x = S2.process(sample);

    double err = S_x - y;
    err_txt << err << "\n";
    fxlms.sh_learn(err);
  }
  fxlms.sh.clear_buffer();

  std::cout << "running ANC...\n";
  const int BLOCK = 10;
  for (int i = 0; i < ambient.num_samples(); ++i) {

    double x_in = ambient.next_sample();
    double anc_y = fxlms.w_process(x_in);
    double err = ambient.calculate_error(anc_y);
    fxlms.w_learn(err);

    // fill output buffers
    anc_buffer[0][i] = anc_y;
    err_buffer[0][i] = err;
  }
  fxlms.w.print_coefs();

  if (!out_file.setAudioBuffer(anc_buffer)) {
    std::cerr << "failed to copy samples from buffer to ANC file\n";
    return 1;
  }
  if (!out_file.save("anc_out.wav")) {
    std::cerr << "failed to save ANC output file\n";
    return 1;
  }

  if (!out_file.setAudioBuffer(err_buffer)) {
    std::cerr << "failed to copy samples from buffer to error file\n";
    return 1;
  }
  if (!out_file.save("anc_err.wav")) {
    std::cerr << "failed to save ANC error file\n";
    return 1;
  }

  return 0;
}

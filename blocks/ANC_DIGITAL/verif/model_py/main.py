
# ==== Default libs ====
import sys

# ==== Requirements ====
import numpy as np
import scipy.io.wavfile as wav
import easygui

# ==== Internal ====
from Simulation import Simulation
from PlotTool import PlotTool



def main():
	
	print("Choose a .wav file to simulate...")
	fs, x = wav.read(easygui.fileopenbox())

	showEstimation = easygui.ynbox('Do you want to see the S filter estimation?', 'S Filter Estimator', ('Yes', 'No'))

	x = x / 2.0 ** 15  # Normalizo la entrada porque esta como bytes enteros

	PlotTool.plot_input_signal_magnitude(
		x,
		title="Input Signal Magnitude",
		xlabel="Sample Index",
		ylabel="Normalized Amplitude"
	)


	if x[0].shape != ():  # Si es estereo solo agarro 1 canal
		x = x.transpose()[0]

	# x = np.array([0.5*np.sin(2*3.142*i * 400/44100.0) for i in range(661500)]) # Si le quiero meter una senoidal perfecta.
	
	print("Simulation Started")

	sim = Simulation(x, fs, 10)

	sim.approximateS(1, showEstimation=showEstimation)

	en, test = sim.simulate()
 
 #Tentativa de avaliar PSNR e MSE
	
	test2= test/max(abs(test))

	x2= x/max(abs(x))

	nrl_value = PlotTool.calculate_nrl(x2,(x2+test2))  # x é o sinal original, x2 é o sinal processado

	print(f"NRL (Noise reduction Level) db: {nrl_value}")

 	#Plot das Saídas
	wav.write("out.wav", fs, np.array(en * 2.0 ** 15, dtype='int16'))
	wav.write("out_2.wav", fs, np.array((x2+test2) * 2 ** 15, dtype='int16'))

	# Ploteo la salida
	plotResults = easygui.ynbox('Do you want to plot the ANC Results?', 'Results', ('Yes', 'No'))

	if plotResults:
     
		graphics = PlotTool()
		showTestProbe = easygui.ynbox('Do you want to show the Test Probe?', 'Results', ('Yes', 'No'))
		if showTestProbe:
			graphics.plot(x, en, fs, test=test)
		else:
			graphics.plot(x, en, fs, test= None)
			
	print("Output from the ANC out.wav has been created.")
	input("Press Enter to exit...")


if __name__ == "__main__":
	main()

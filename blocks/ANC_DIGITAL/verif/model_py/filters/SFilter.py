import numpy as np

# H(z) = 1 / ( 1 + gz ^ -M )

class SFilter:
	def __init__(self):
		self.M = 2
		self.values = np.zeros(self.M)

	def filter(self, x):

		y = np.ndarray(len(x))
		g = 0.5
		y_tot = np.append(self.values, np.ndarray(len(x)))

		for n in range(len(x)):
			y[n] = x[n] - g * y_tot[n] - 0.3 * y_tot[n + 1]
			y_tot[n+self.M] = y[n]

		for i in range(self.M):
			self.values[i] = y[len(y) - self.M + i]
		# Si tengo y=[y1,y2,y3,y4,...,y10] agarro los ultimos M valores
		# pej, si M = 3 entonces prevValues=[y8,y9,y10]
		return y

	def reset(self):
		self.values = np.zeros(self.M)

	def _save_values(self, x : np.ndarray) -> None:

		for i in range(self._order):
			self.prev_values[i] = x[ len(x) - self._order + i]
	

import numpy as np

from filters.FXLMS import FXLMS
from filters.SFilter import SFilter

# y(n) = (-1)*(a_0 x(n) + a_1 x(n-1) + ...)

class WienerFilter:

	def __init__(self, order : int, alpha):

		if order < 0 or order > 255:
			raise ValueError("Order must be between 0 and 255")

		self._order = order

		self.coefficients = np.zeros(order)

		self.alpha = alpha

		self.fxlms = FXLMS(self.alpha)

		self.prev_values = np.zeros(order)

		self.last_x = None


	def filter(self, x): ######

		y = np.ndarray( len(x) )

		x_tot = np.concatenate((self.prev_values, x))

		self.last_x = x_tot  # Guardo esto para usar en otras funciones
		
		for n in range( len(x) ):

			temp = 0
			n_tot = n + self._order

			for i in range(1, self._order):
				if n_tot > i:
					temp = temp - x_tot[n_tot - i] * self.coefficients[i]

			y[n] = - self.coefficients[0] * x[n] + temp

			y[n] = WienerFilter.clamp(y[n], -2, 2)

		self._save_values(x)

		return y

	def updateCoefs(self, signal, error_n): ######
		# Mando a=[a_0,a_1,a_2,...] y signal=[x(n),x(n-1),...,x(n-N)]
		if self.alpha > 1e-6:
			self.coefficients = self.fxlms.calcNewCoef( self.coefficients, signal, error_n, self.alpha)

	def update(self, error, sfilter : SFilter | None = None): ######

		x_tot = 0

		if sfilter is not None:
			x_tot = sfilter.filter(self.last_x)
		else:
			x_tot = self.last_x
		
		signal = np.ndarray(self._order)
		for n in range(len(error)):
			for i in range(self._order):
				signal[i] = x_tot[n + self._order - i]
			# Cargo los valores previos para mandar al algoritmo
			# Osea para actualizar los coeficientes en n, necesito
			# x(n), x(n-1), x(n-2), ..., x(n-N), siendo M la cantidad
			# de coeficientes.
			# signal = [x(n), x(n-1), ... , x(n-N)]
			self.updateCoefs(signal, error[n])
		return

	def updateAlpha(self, decreace): ######

		if decreace:
			self.alpha = self.alpha / 2.0
		elif self.alpha:
			self.alpha = self.alpha * 2.0

	def reset(self):
		self.prev_values = np.zeros(self._order)
		self.last_x = None

	def _save_values(self, x : np.ndarray) -> None:

		for i in range(self._order):
			self.prev_values[i] = x[ len(x) - self._order + i]

	def clamp(value : int, min_ : int, max_ : int):

		if value < min_:
			return min_

		if value > max_:
			return max_

		return value
	
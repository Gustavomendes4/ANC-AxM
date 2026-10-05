import numpy as np

# H(z)= Pol(z ** -1)

# y[n]	=	( 1 * x[n] ) + ( 0.5 * x[n-1] ) + ( 0.25 * x[n-2] ) + ( 0.125 * x[n-3] ) + ( 0.01 * x[n-4])

# Calculo do PFilter
# y[m] = x_tot[n] + 0.5 * x_tot[n - 1] + 0.25 * x_tot[n - 2] + 0.125 * x_tot[n - 3] + 0.01 * x_tot[n - 4]


#  y[n] = SIGMA[ 0.5^n * x[ N - n] ]

# Isso é um Filtro FIR !!

class PFilter:

	def __init__(self, order : int = 4):

		# Inicializa Order
		if not (1 <= order <= 10):
			raise ValueError("A ordem do filtro deve estar entre 1 e 10.")
		else:
			self._order = order

		# initialize Values
		self.values = np.zeros(self._order)

		# Create coefficients
		self.coefficients = []

		# GAMBIARRA: para manter o que foi definido pelo uruguaio
		if self._order == 4:
			self.coefficients = [1.0, 0.5, 0.25, 0.125, 0.01]

		else:
			for i in range(self._order + 1):
				self.coefficients.append(0.5**i)

	def filter(self, x : np.ndarray ):

		y = np.zeros( len(x) )

		x_tot : np.ndarray = np.concatenate((self.values, x))

		for m in range( len(x) ):
			n = m + self._order

			# Coleta ORDER amostras e inverte
			amostras = x_tot[ n - self._order : n + 1][::-1]

			# Calculo da EDO
			y[m] = self._convolucao_linear( *amostras )


		self._save_values(x)

		return y

	def reset(self):
		self.values = np.zeros(self._order)

	def _convolucao_linear(self, *args : float | int) -> float:

		if len(args) != ( self._order + 1):
			raise ValueError(f"PFilter definido como Ordem={self._order}; numero invalido de argumentos: {len(args)}")

		summ = 0

		for i in range(0, self._order + 1):
			summ += args[i] * self.coefficients[i]

		return float(summ)

	def _save_values(self, x : np.ndarray) -> None:

		for i in range(self._order):
			self.values[i] = x[ len(x) - self._order + i]
	

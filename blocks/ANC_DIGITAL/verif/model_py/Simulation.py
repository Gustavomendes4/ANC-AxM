import numpy as np
from PlotTool import PlotTool
from tqdm import tqdm


from filters.WienerFilter import WienerFilter
from filters.SFilter import SFilter
from filters.PFilter import PFilter
import filters.FXLMS as FXLMS

from converters.converter import Converter

def map_L_to_binary_string(L):
    if not (1 <= L <= 16):
        raise ValueError("L deve estar entre 1 e 16")

    value = ((1 << L) - 1) << (16 - L)  # Gera o inteiro com L bits 1 à esquerda
    binary_string = format(value, '016b')  # Formata como string de 16 bits
    return binary_string

def rtl_simulation(modelsim_process, rtl_in, rtl_dn, lines_to_skip):
    # Converter inputs para binário
    #print(rtl_in)
    #print(rtl_dn)
    binary_in = Converter.float_to_binary(rtl_in, N=16, F=14)
    binary_L = map_L_to_binary_string(FXLMS.L_precison)
    #print(binary_in)
    binary_dn = Converter.float_to_binary(rtl_dn, N=16, F=14)
    #print(binary_dn)
    # Forçar valores no ModelSim
    #print(binary_in)
    #print(binary_dn)
    
    #input("Pressione Enter para continuar...")
    modelsim_process.stdin.write(f"force -freeze x_in {binary_in}\n")
    modelsim_process.stdin.write(f"force -freeze L {binary_L}\n")
    modelsim_process.stdin.write(f"force -freeze dn {binary_dn}\n")
    
    # Executar a simulação
    modelsim_process.stdin.write("run 20ns\n")
    modelsim_process.stdin.flush()
    # Ignorar as primeiras 'lines_to_skip' linhas até encontrar a linha desejada
    # Manual buffer consumption error, need to define the firsts 120 lines to be consuming
    # def simulate(self) ---> need change the starting lines_to_skip there
    if lines_to_skip==131 + 10:
    	for _ in range(lines_to_skip):
         #modelsim_process.stdout.readline().strip()
         teste = modelsim_process.stdout.readline().strip()
         print(teste)
    if lines_to_skip>131:
    	for _ in range(4):
         modelsim_process.stdout.readline().strip()     
         
    modelsim_process.stdin.write("examine -value tb_ANC.out\n")
    modelsim_process.stdin.flush()
    
    teste = modelsim_process.stdout.readline().strip()
    #print(teste)
    #time.sleep(0.00000002)
    # Capturar apenas a linha da saída esperada
    output_rtl_xp = modelsim_process.stdout.readline().strip()
    #print (output_rtl_xp)
    return output_rtl_xp

def bin_to_signed_decimal(binary_str):
    num_bits = len(binary_str)
    # Verifica se o MSB (mais significativo) é 1 (negativo)
    if binary_str[0] == '1':
        # Número negativo: complemento de dois
        complemento = (1 << num_bits) - int(binary_str, 2)  # Calcula o complemento
        return -complemento
    else:
        # Número positivo
        return int(binary_str, 2)

class Simulation:

    def __init__(self, inp, fs, order):
        self.x = inp
        self.fs = fs
        self.orden = order
        self.en = np.zeros(len(self.x))  # Inicializar com zeros

        self.wfilter = WienerFilter(self.orden, 2e-1)
        self.sfilter = SFilter()
        self.pfilter = PFilter()

        self.sApproxFiler = WienerFilter(self.orden, 1e-3)
        return

    def simulate(self):
        test = np.zeros(len(self.x))

        yn_all = []

        xp_all = []
        
        print("Simulating ANC...")
        
        # Dados do vetor de entrada
        maximo = np.max(self.x)
        minimo = np.min(self.x)
        media = np.mean(abs(self.x))
        
        # Exibindo os resultados
        print(f"Valor máximo: {maximo}")
        print(f"Valor mínimo: {minimo}")
        print(f"Valor médio: {media}")
        input("Pressione Enter para continuar...")
        
        
        for i in tqdm(range(int(len(self.x) / self.orden))):
            inp = self.x[self.orden * i: self.orden * i + self.orden]
            xp = self.wfilter.filter(inp)
            xp_all.extend(xp)
            yn = self.sfilter.filter(xp)
            yn_all.extend(yn)  # Acumular valores para plotagem
            dn = self.pfilter.filter(inp)
            error = dn + yn

            self.en[self.orden * i: self.orden * i + self.orden] = error
            test[self.orden * i: self.orden * i + self.orden] = xp
            self.wfilter.update(error, self.sApproxFiler)
                
        print("Finished Simulating ANC...")

        return self.en, test
    
    def approximateS(self, estimationTime, showEstimation=False):

        approximationTime = int(44.1e3 * estimationTime)

        x = np.array([0.5 * np.sin(2 * 3.142 * i * 400 / 44100.0) for i in range(approximationTime)])

        print("Estimating S Filter...")

        test = np.ndarray(len(x))

        for i in tqdm(range(int(len(x) / self.orden))):
            inp = x[self.orden * i: self.orden * i + self.orden]
            dn = self.sfilter.filter(inp)
            y = self.sApproxFiler.filter((-1) * inp)
            e = dn + y
            test[self.orden * i: self.orden * i + self.orden] = e
            self.sApproxFiler.update(e)

        print("Finished Estimating Filter")

        #print("Filter Parameters: ", self.sApproxFiler.a)
        if showEstimation:
            plot = PlotTool()
            plot.plot(x, test, 44.1e3)

        self.sApproxFiler.reset()

        self.sfilter.reset()


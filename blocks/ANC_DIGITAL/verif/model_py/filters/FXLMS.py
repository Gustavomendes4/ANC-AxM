
from converters.converter import Converter

import numpy as np
import matplotlib.pyplot as plt

L_precison=16 
mred_accumulator = 0
total_samples = 0  # Contador para todas as amostras processadas
mred=0

L_vals = []
sample_vals = []
f = open('operandos_mred_2%.txt', 'a')

def plot_dynamic_graph(sample_vals, L_vals):
    plt.figure(figsize=(10, 6))  # Define o tamanho da figura (largura, altura)
    
    # Plotar a curva com estilo
    plt.plot(sample_vals, L_vals, color='blue', marker='o', linestyle='-', linewidth=2, markersize=4, label="L Levels")
    
    # Adicionar título e rótulos com tamanho de fonte ajustado
    plt.title("Dynamic L level on each time sample", fontsize=16)
    plt.xlabel("Time sample", fontsize=12)
    plt.ylabel("L Levels", fontsize=12)
    
    # Adicionar grade para melhor visualização
    plt.grid(True, which='both', linestyle='--', linewidth=0.5)
    
    # Adicionar uma legenda
    plt.legend(loc="best", fontsize=12)
    
    # Exibir o gráfico
    plt.show()

def plot_histogram(L_vals, filename="histogram.pdf"):
    # Calculate mean, median, variance, and standard deviation
    mean = np.mean(L_vals)
    median = np.median(L_vals)
    variance = np.var(L_vals)
    std_dev = np.std(L_vals)

    # Count the frequencies of the L values using an appropriate number of bins
    counts, bins = np.histogram(L_vals, bins='auto')  # 'auto' adjusts the number of bins automatically

    # Define bar width and "artificial spacing"
    width = 0.8
    spacing = 0.1
    positions = bins[:-1] + spacing / 2

    # Create the histogram
    plt.figure(figsize=(10, 6))
    plt.bar(positions, counts, width=width, color='blue', edgecolor='black', alpha=0.7)

    # Add vertical lines for mean, median, and standard deviation
    plt.axvline(mean, color='red', linestyle='dashed', linewidth=1, label=f'Mean: {mean:.2f}')
    plt.axvline(median, color='orange', linestyle='dashed', linewidth=1, label=f'Median: {median:.2f}')
    plt.axvline(mean + std_dev, color='green', linestyle='dashed', linewidth=1, label=f'Standard Deviation: {std_dev:.2f}')
    plt.axvline(mean - std_dev, color='green', linestyle='dashed', linewidth=1)

    # Add labels with specified font sizes
    plt.xlabel("L Levels", fontsize=20)
    plt.ylabel("Frequency", fontsize=20)

    # Customize tick parameters for axes
    plt.tick_params(axis='both', labelsize=16)

    # Add legend with specific font size
    plt.legend(fontsize=16)

    # Add grid to the histogram
    plt.grid(True, which='both', linestyle='--', linewidth=0.5)

    # Save the histogram as a PDF
    plt.savefig(filename, format='pdf', bbox_inches='tight')

    # Optionally, display the histogram
    plt.show()

def encontrar_bit_esquerda_1(numero, L):
    for i in range(15, -1, -1):
        if numero & (1 << i):
            shift = i - L + 1
            if shift >= 0:
                numero >>= shift
                numero <<= shift
                return numero
            else:
                return numero
    return numero

def calculate_result(a, b):
    
    global L_precison
    global mred
    global mred_accumulator, total_samples
    global L_vals
    global sample_vals
    L = L_precison
    
    L_vals.append(L)
    sample_vals.append(total_samples)
    
    # Salva os sinais originais
    sinal_a = -1 if a < 0 else 1
    sinal_b = -1 if b < 0 else 1
    
    a_int = Converter.float_to_int16(abs(a))
    b_int = Converter.float_to_int16(abs(b)) 
    
    #Salva os valores operandos e precisão definida
    #with open('operandos.txt', 'a') as f:
    f.write(f"{bin(abs(a_int))[2:].zfill(16)}\n")  # Corrigido para remover parênteses extras
    f.write(f"{bin(abs(b_int))[2:].zfill(16)}\n")  # Corrigido para remover parênteses extras
    f.write(f"{L}\n")
    # Multiplicação sem sinal
    A = encontrar_bit_esquerda_1(a_int, L)
    B = encontrar_bit_esquerda_1(b_int, L)
    #print(a_int)
    #print(A)
    # Multiplicação sem sinal
    r = A * B
    original_value = a_int*b_int
    #print(r)
    #print(original_value)
    
    # Ajustar o sinal, XOR para definir o sinal final com base nos sinais de a e b
    if (sinal_a ^ sinal_b) == -2:  # sinais opostos
        r = -r
        original_value = -original_value
        
    r_float = Converter.int16_to_float(r)
    original_value_float = Converter.int16_to_float(original_value)
    
    # Calcular o erro
    error = abs(r_float - original_value_float)
    #if error!=0:
    #    print(error)
    #    print(r_float)
    #    print(original_value_float)
    #    return None
    # Calcular o erro relativo
    if original_value_float != 0:  # Evitar divisão por zero
        relative_error = error / abs(original_value_float)
    else:
        relative_error = 0  # Se o valor original for 0, o erro relativo não existe
   # print(relative_error)
    # Acumular erro relativo ao quadrado
    mred_accumulator += relative_error
    total_samples += 1
   
    # Calcular o MSRE contínuo (média acumulada do erro)
    mred = mred_accumulator / total_samples
    #print(relative_error)
    #print(mred)
    # Verifica o limite de 10%
    if mred < 0.05:  # 10% do valor original
        if L_precison > 1:  # Limite inferior
            L_precison -= 1  # Decrementa L
    else:
        if L_precison < 16:  # Limite superior
            L_precison += 1  # Incrementa L se o erro for maior ou igual a 10%
    #print(L_precison)
    #print(total_samples)
    #if total_samples == 2781240:
    if total_samples == 2000000:
        # Plotar o gráfico
        print(mred)
        #plot_dynamic_graph(sample_vals, L_vals)
        plot_histogram(L_vals)

    return r_float # Retorna o valor final já ajustado com o sinal

class FXLMS: 
    def __init__(self, alpha):
        self.alpha = alpha

    def calcNewCoef(self, a_n, signal, error_n, alpha):
        self.alpha = alpha
        #filter funcion in 3-steps
        filter_axm = a_n
        # Multiplicação
        mult1 = 2*self.alpha #calculate_result(2, self.alpha)
        mult2 = calculate_result(error_n, mult1)  #error_n*mult1
        #colocar termo a termo na multiplicação
        # Chamada de calculate_result para cada termo de signal
        for i in range(len(signal)):
            filter_axm[i] += calculate_result(signal[i], mult2) #signal[i]*mult2
        #filter_axm += calculate_result(signal, mult2)   
        #print(mult1)
        #print(mult2)
        #print(filter_axm)
        #print(mred)
        return filter_axm

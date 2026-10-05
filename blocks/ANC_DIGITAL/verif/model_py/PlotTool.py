import numpy as np
import matplotlib.pyplot as plt

class PlotTool:

    def plot(self, x, en, fs, test=None, filename=None):
        # Criando vetor de tempo t
        t = np.ndarray(len(x))
        for i in range(len(x)):
            t[i] = 1 / fs * i
        
        # Estilizando o gráfico
        plt.figure(figsize=(10, 6))  # Ajusta o tamanho da figura
        plt.grid(which='both', linewidth=0.3, color='gray', linestyle='--', alpha=0.7)  # Grid suave e leve
        
        # Plotando o gráfico com diferentes sinais
        if test is not None:
            plt.plot(t, test, "r", label="Processed Output Signal (ANC Filtered)", linewidth=1.0)  # Sinal do alto-falante (vermelho)
        plt.plot(t, x, 'k', label="Noisy Input Signal", linewidth=1.2)  # Sinal de entrada (preto)
        plt.plot(t, en, "#4d4d4d", label="Error Signal (Residual Noise)", linewidth=1.2)  # Sinal de saída (cinza escuro)
        
        # Ajuste do título e rótulos com fontes e tamanhos apropriados
        plt.title("Signal Plot for ANC System", fontsize=18, fontweight='bold', family='Times New Roman')
        plt.xlabel("Time (s)", fontsize=16, fontweight='bold', family='Times New Roman')  # Rótulo X
        plt.ylabel("Amplitude (V)", fontsize=16, fontweight='bold', family='Times New Roman')  # Rótulo Y
        
        # Limites do gráfico e ajustes no eixo X
        plt.xlim(0, t[-1])
        
        # Melhorando a legenda
        plt.legend(loc='upper right', fontsize=12, frameon=True, facecolor='white', edgecolor='black', 
                   framealpha=1.0, borderpad=1, borderaxespad=1)  # Fundo sólido na legenda

        # Ajustes do layout e margens
        plt.tight_layout()

        # Salvar o gráfico como PDF com nome de arquivo único
        if filename is None:
            filename = "ANC_Results_{}.pdf".format(np.random.randint(1000))  # Nome de arquivo único
        plt.savefig(filename, format='pdf', bbox_inches='tight')
        
        # Exibindo o gráfico
        plt.show()
    
    def calculate_nrl(input_signal, anc_signal):

    # NRL = 10 * log( P_antes / P_depois )

    # Calcula a potência média dos sinais
        power_original = np.mean(np.square(input_signal))
        power_anc = np.mean(np.square(anc_signal))

    # Verifica se a potência do sinal ANC é zero para evitar erro de log
        if power_anc == 0:
            return np.inf  # NRL infinito se o sinal ANC cancelou totalmente o ruído

    # Calcula o NRL em dB
        nrl = 10 * np.log10(power_original / power_anc)  # Ajuste para a fórmula de potência

        return nrl

    def plot_signals(signal1, signal2, title="Signal Comparison", label1="Signal 1", label2="Signal 2"):
        plt.figure(figsize=(10, 6))
        plt.plot(signal1, label=label1, color='blue', linestyle='-', linewidth=1)
        plt.plot(signal2, label=label2, color='red', linestyle='--', linewidth=1)



        plt.title(title, fontsize=18, fontweight='bold', family='Times New Roman')
        plt.xlabel("Sample Index", fontsize=16,fontweight='bold', family='Times New Roman')
        plt.ylabel("Output Signal Magnitude", fontsize=16, fontweight='bold', family='Times New Roman')
        plt.grid(True, linestyle='--', alpha=0.7)
        plt.legend(loc="upper right", fontsize=10)
        plt.tight_layout()
        plt.show()
        
    def plot_nrl_over_time(nrl_values, title="NRL Over Time", xlabel="Time", ylabel="NRL (dB)"):

        """
        Função para plotar o gráfico do módulo da NRL ao longo do tempo.
        
        Parameters:
        nrl_values (list or array): Lista/array de valores de NRL calculados ao longo do tempo.
        title (str): Título do gráfico.
        xlabel (str): Rótulo do eixo X.
        ylabel (str): Rótulo do eixo Y.
        """

        plt.figure(figsize=(10, 6))
        plt.plot(nrl_values, label="NRL", color='darkgreen', linestyle='-', linewidth=1)


        plt.title(title, fontsize=18, fontweight='bold', family='Times New Roman')
        plt.xlabel(xlabel, fontsize=16, fontweight='bold', family='Times New Roman')
        plt.ylabel(ylabel, fontsize=16, fontweight='bold', family='Times New Roman')
        plt.grid(True, linestyle='--', alpha=0.7)
        plt.legend(loc="upper right", fontsize=10)
        plt.tight_layout()
        plt.show()

    def plot_input_signal_magnitude(x, title="Input Signal Magnitude", xlabel="Time Index", ylabel="Normalized Amplitude"):
        """
        Plots the magnitude of the input signal over time with the mean value line.
        Styled for IEEE paper presentation.
        
        :param x: Input signal to be plotted
        :param title: Plot title
        :param xlabel: Label for the X axis
        :param ylabel: Label for the Y axis
        """
        # Magnitude do sinal de entrada e média
        abs_x = np.abs(x)
        mean_value = np.mean(abs_x)

        # Criação do gráfico
        plt.figure(figsize=(10, 6))
        
        # Plotando o sinal com o módulo em escala de cinza e o valor médio em azul
        plt.plot(abs_x, color='dimgray', linewidth=2)
        plt.axhline(y=mean_value, color='blue', linestyle='--', linewidth=2)
        
        # Configuração de título e rótulos para paper IEEE
        plt.title(title, fontsize=18, fontweight='bold', family='Times New Roman')
        plt.xlabel(xlabel, fontsize=16, fontweight='bold', family='Times New Roman')
        plt.ylabel(ylabel, fontsize=16, fontweight='bold', family='Times New Roman')
        
        # Ajuste da grade e aparência geral
        plt.grid(True, linestyle=':', color='gray', alpha=0.7)
        
        # Anotação do valor médio com fundo branco opaco
        plt.text(len(abs_x) * 0.7, mean_value * 1.1, f'Mean = {mean_value:.4f}', 
                 color='blue', fontsize=14, fontweight='bold', family='Times New Roman',
                 bbox=dict(facecolor='white', edgecolor='none', alpha=0.8))
        
        # Layout ajustado
        plt.tight_layout()
        
        # Mostrando o gráfico
        plt.show()

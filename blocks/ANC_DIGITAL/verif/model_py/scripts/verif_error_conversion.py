import math

from converters.converter import Converter

# Processar arquivo e calcular estatísticas
def analyze_conversion(file_path, N, F):
    with open(file_path, "r") as file:
        lines = file.readlines()
    
    total_error = 0
    max_error = -math.inf
    min_error = math.inf
    num_values = 0
    last_10_values = []  # Armazena os últimos 10 valores

    for line in lines:
        try:
            original_value = float(line.strip())
        except ValueError:
            continue  # Ignorar linhas inválidas

        binary_repr = Converter.float_to_binary(original_value, N, F)
        converted_value = Converter.binary_to_float(binary_repr, N, F)

        error = abs(original_value - converted_value)
        total_error += error
        max_error = max(max_error, error)
        min_error = min(min_error, error)
        num_values += 1

        # Armazenar os últimos 10 valores
        last_10_values.append((original_value, binary_repr, converted_value, error))
        if len(last_10_values) > 10:
            last_10_values.pop(0)

    mean_error = total_error / num_values if num_values > 0 else 0

    # Exibir os últimos 10 valores processados
    print("\nOs 10 últimos valores processados:")
    print(f"{'Original':>15} {'Binário':>20} {'Convertido':>15} {'Erro':>10}")
    for original_value, binary_repr, converted_value, error in last_10_values:
        print(f"{original_value:>15.8f} {binary_repr:>20} {converted_value:>15.8f} {error:>10.8f}")

    return {
        "mean_error": mean_error,
        "max_error": max_error,
        "min_error": min_error,
        "num_values": num_values,
    }

if __name__ == "__main__":
    file_path = r"C:\Users\Gustavo\Desktop\ANC-dft\samples\dn_values.txt"
    N = 16
    F = 11

    results = analyze_conversion(file_path, N, F)
    
    print("\nResultados da análise:")
    print(f"Número de valores analisados: {results['num_values']}")
    print(f"Erro médio: {results['mean_error']:.6f}")
    print(f"Erro máximo: {results['max_error']:.6f}")
    print(f"Erro mínimo: {results['min_error']:.6f}")

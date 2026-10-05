from converters.file_converter import FileConverter as FC

# Parâmetros de formato
TOTAL_BITS       = 16
BITS_FOR_DECIMAL = 11

# Files
INPUT_FILES = [
    r'C:\Users\Gustavo\Desktop\ANC-dft\samples\dn_values.txt',
    r'C:\Users\Gustavo\Desktop\ANC-dft\samples\in_values.txt'
]

OUTPUT_FILES = [
    r'dn_tb.txt',
    r'in_tb.txt'
]


total = 0

# Processar os arquivos
for in_file, out_file in zip(INPUT_FILES, OUTPUT_FILES):

    print(f"Convertendo: {in_file}")

    total = FC.float_to_binary(in_file, out_file, TOTAL_BITS, BITS_FOR_DECIMAL)

    print(f"Convertido para: {out_file}")
    print(f"Total de linhas: {total}\n")


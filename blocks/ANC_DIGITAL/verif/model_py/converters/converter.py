from abc import ABC

class Converter(ABC):

    @staticmethod
    def toInt(src):
        ...

    @staticmethod
    def float_to_binary(number: float, number_of_bits : int, bits_for_decimal : int) -> str:
      
        number = number * (2**10)

        scaled_num = int( round( number * (2**bits_for_decimal) ) ) 
    
        # Mantém apenas os N bits mais significativos
        scaled_num &= (1 << number_of_bits) - 1 

        # Se for negativo, converter para complemento de dois
        if scaled_num < 0:
            scaled_num = (1 << number_of_bits) + scaled_num
    
        # Formatar como string binária com largura N
        binary_str = f"{scaled_num:0{number_of_bits}b}"

        return binary_str

    @staticmethod
    def binary_to_float(binary_str : str, number_of_bits : int, bits_for_decimal : int) -> float:

        raw_val = int(binary_str, 2)

        raw_val = raw_val/(2**10)

        # Verificar se é negativo em complemento de dois
        if raw_val >= (1 << (number_of_bits - 1)):  
            raw_val -= (1 << number_of_bits)

        return raw_val / (2**bits_for_decimal)

    @staticmethod
    def int16_to_float(value : int):
        return value / (2**15)
        # return value / 32768.0
        # return (value / (32768*35768))
    
    @staticmethod
    def float_to_int16(value : float):

        if value < -32768 or value > 32767:
        # if value < -1.0 or value > 1.0:
            ...
        # raise ValueError(f"O valor deve estar entre -32768 e 32767. ({value})")

        return int(value * (2**15))
    
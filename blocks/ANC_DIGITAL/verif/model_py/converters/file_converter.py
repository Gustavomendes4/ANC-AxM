from abc import ABC
from pathlib import Path

from converters.converter import Converter

class FileConverter(ABC):

    @staticmethod
    def float_to_binary(
        intput : str | Path,
        output : str | Path,
        number_of_bits: int,
        bits_for_decimal: int
    ) -> int:

        total_processed = 0

        with open(intput, 'r') as infile, open(output, 'w') as outfile:
        
            for line in infile:
                line = line.strip()
        
                if not line:
                    continue
        
                try:
                    value  = float(line)
                    
                    binary = Converter.float_to_binary(value , number_of_bits, bits_for_decimal)

                    outfile.write(binary + '\n')

                    total_processed += 1
        
                except ValueError as e:
                    raise ValueError(
                        f"Erro ao converter linha {total_processed}: {line!r}"
                    ) from e

        return total_processed

    
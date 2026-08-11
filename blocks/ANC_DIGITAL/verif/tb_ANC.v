`timescale 1ns/1ps
/*
function real fixed_to_real(
    input [15:0] fixed_val // Representação ponto fixo de 16 bits
);
    integer i;
    real integer_part, fraction_part;
    reg signed [15:0] unsigned_val; // Variável para armazenar o valor sem sinal
    real result;

    // Etapa 1: Ajustar para valor positivo se necessário (complemento de dois)
    if (fixed_val[15] == 1'b1) begin
        // Valor negativo, aplicar complemento de dois
        unsigned_val = ~fixed_val + 1;
    end else begin
        // Valor positivo
        unsigned_val = fixed_val;
    end

    // Etapa 2: Converter para valor real
    integer_part = unsigned_val >> 11; // Extrair parte inteira
    fraction_part = 0;
    for (i = 0; i < 11; i = i + 1) begin
        if (unsigned_val[i]) begin
            fraction_part = fraction_part + (1.0 / (1 << (i + 1))); // 2^-(i+1)
        end
    end

    result = integer_part + fraction_part;

    // Etapa 3: Ajustar o sinal
    if (fixed_val[15] == 1'b1) begin
        // Número originalmente negativo
        result = -result;
    end

    fixed_to_real = result;

    fixed_to_real = fixed_to_real /(1 << 10);
endfunction*/

module tb_ANC;

    // Parâmetros
    parameter N = 16;
    parameter F = 14;

    // Sinais do DUT
    reg clock;
    reg reset;
    reg [N-1:0] x_in;  // Entrada do sistema
    reg [N-1:0] dn;    // Sinal desejado
    reg [N-1:0] mi;    // Taxa de aprendizado
    wire [N-1:0] en;   // Sinal de erro
    wire [N-1:0] out;  // Saída do filtro
 
    initial begin
        $dumpfile("tb_ANC.vcd");
        $dumpvars(0, tb_ANC);
    end
    // DUT Instância
    ANC #(.N(N), .F(F)) DUT (
        .clock(clock),
        .reset(reset),
        .x_in(x_in),
        .dn(dn),
        .mi(mi),
        .en(en),
        .out(out)
    );

    // Clock Generator
    initial begin
    clock = 0;      // Inicializa o clock em 0
    #1 clock = 1;   // Após 1ns, define o clock para 1
    end
    always #10 clock = ~clock;
    integer count;

    // Simulação
    initial begin

        // Inicialização
        reset = 1;
        x_in = 0;
        dn = 0;
        mi = 16'h0CCC;//valor fixo da taxa de aprendizado
      
        // Aguardar estabilidade do clock
        #3 reset = 0;

        // Simulação principal controlada via Python
        count = 0;
        while (1) begin
            @(posedge clock);

            // Aguardar valores forçados pelo comando externo
            #1; // Pequeno atraso para estabilizar sinais externos

            // Contador de amostras
            count = count + 1;

            // Monitoramento de saídas (opcional, pode ser retirado se controlado totalmente por Python)
            //$display("Time: %0dns, x_in: %b, dn: %b, out: %b", $time, x_in, dn, out);
        end

        #100 $stop;
    end

endmodule

/*module tb_ANC;

    // Parâmetros
    parameter N = 16;
    parameter F = 11;

    // Sinais do DUT
    reg clock;
    reg reset;
    reg [N-1:0] x_in;  // Entrada do sistema
    reg [N-1:0] dn;    // Sinal desejado
    reg [N-1:0] mi;    // Taxa de aprendizado
    wire [N-1:0] en;   // Sinal de erro
    wire [N-1:0] out;  // Saída do filtro
 

    // Arquivos
    integer file_x_in, file_dn, file_out,file_out2, file_log;
    integer scan_x_in, scan_dn, scan_out;
    reg [N-1:0] x_in_data, dn_data, out_expectedbin;
    real out_expected, out_dut,error;

    // DUT Instância
    ANC #(.N(N), .F(F)) DUT (
        .clock(clock),
        .reset(reset),
        .x_in(x_in),
        .dn(dn),
        .mi(mi),
        .en(en),
        .out(out)
    );

    // Clock Generator
    initial clock = 1;
    always #5 clock = ~clock;

    initial begin
        integer count;

        // Inicialização
        reset = 1;
        x_in = 0;
        dn = 0;
        mi = 16'h019A;

        // Abrir arquivos
        //file_x_in = $fopen("C:/Users/tbedi/Documents/IC/ANC-AxM/in_tb.txt", "r");
        //file_dn = $fopen("C:/Users/tbedi/Documents/IC/ANC-AxM/dn_tb.txt", "r");
        file_out = $fopen("C:/Users/tbedi/Documents/IC/ANC-AxM/outyn_values.txt", "r");
	    //file_out2 = $fopen("C:/Users/tbedi/Documents/IC/ANC-AxM/outyn_tb.txt", "r");
        //file_log = $fopen("C:/Users/tbedi/Documents/IC/ANC-AxM/log_tb.txt", "w"); // Arquivo de log

        if (file_out == 0) begin //|| file_x_in == 0 || file_dn == 0  || file_log == 0) begin
            $display("Erro ao abrir arquivos de entrada/saída esperada.");
            $finish;
        end

        //Ignorar as primeiras 12210 linhas (ajustar conforme necessário)
        //for (count = 0; count < 20200; count = count + 1) begin
            //$fscanf(file_x_in, "%b\n", x_in_data);
            //$fscanf(file_dn, "%b\n", dn_data);
            //$fscanf(file_out, "%f\n", out_expected);
	        //$fscanf(file_out2, "%b\n", out_expectedbin);
        //end

        // Aguardar estabilidade do clock
        #10 reset = 0;

        // Processamento principal, max 735230
        count = 0;
        while (count < 80000) begin
            @(posedge clock);

            // Ler novos valores
            //scan_x_in = $fscanf(file_x_in, "%b\n", x_in_data);
            //scan_dn = $fscanf(file_dn, "%b\n", dn_data);
            scan_out = $fscanf(file_out, "%b\n", out_expected);
	        //scan_out = $fscanf(file_out2, "%b\n", out_expectedbin);

            if (scan_x_in != 1 || scan_dn != 1 || scan_out != 1) begin
                $display("Erro ao ler valores dos arquivos.");
                $finish;
            end

            // Aplicar valores no DUT
            x_in <= x_in;
            dn <= dn;
            out_dut = out; 
            // contador de samples
            count = count + 1;

        end

        // Fechar os arquivos
        //$fclose(file_x_in);
        //$fclose(file_dn);
        $fclose(file_out);
	    //$fclose(file_out2);
        //$fclose(file_log);

        #100 $stop;
    end

   // initial begin
    //   out_dut = fixed_to_real(out); // Chamada da função para converter `out` em `out_dut`
     //   $monitor("Time: %0dns, x_in: %b, dn: %b, out (bin): %b, out (float): %f, esperado(bin): %b ,esperado: %f, erro: %f ", 
      //   $time, x_in, dn, out, out_dut, out_expectedbin  ,out_expected, 
       //  out_dut - out_expected);
    // end

endmodule
*/
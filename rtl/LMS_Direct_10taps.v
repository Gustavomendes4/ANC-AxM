// Truncation 
module TRUN_GEN_C #(
    parameter integer N = 16,
    parameter integer F = 14
)(
    input  wire [4*N-1:0] A,
    output wire [2*N-1:0] Y
);

    wire signed [4*N-1:0] abs_val;   // Valor absoluto
    wire signed [2*N-1:0] truncated; // Valor truncado

    assign truncated = {A[4*N-1], A[(2*F)+3:2*F],A[2*F-1:F]};
    // Operador ternário para restaurar sinal ou zerar
    assign Y = (truncated == {2*N{1'b1}}) ? 0 : truncated;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/*
Copyright (c) 2015 Soheil Hashemi (soheil_hashemi@brown.edu)
              2018 German Research Center for Artificial Intelligence (DFKI)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

Approximate Multiplier Design Details Provided in:
Soheil Hashemi, R. Iris Bahar, and Sherief Reda, "DRUM: A Dynamic
Range Unbiased Multiplier for Approximate Applications" In
Proceedings of the IEEE/ACM International Conference on
Computer-Aided Design (ICCAD). 2015. 
*/
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Adder
module SUM_GEN #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output reg signed [N-1:0] Y
);
    reg c_out;
    //carry calculado errado, vale apenas para positivos
    always @ (A or B) begin
        {c_out, Y}=A+B;
    end
endmodule


//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Subtractor
module SUB_GEN #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output signed [N-1:0] Y
);

    assign Y = A - B;
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Register with synchronous clear
module REG #(
    parameter N=16
)(
    input clock, 
    input CL,
    input[N-1:0] A,
    output reg[N-1:0] S
);

    always @(posedge clock) begin
        if (CL) S = {N{1'b0}};
        else S = A;
    end
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Multiplier
module MULT_GEN #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output signed [2*N-1:0] Y
);
    //TODO: fiquei em dúvida se isso funciona para ponto fixo, como como o valor é o floar << F ao multiplciar teriamos um
    //valor deslocado duas vezes por F ((A << F) * (B << F) = ((A*B) << (2*F))), então acho que deveria ter um >> F para manter o PF.
    assign Y = A * B;
endmodule

//Multiplier
module MULT_GEN2 #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output signed [2*N-1:0] Y
);

    assign Y = A * B;
endmodule


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Adder Tree adder
module ADDER_SHIFT #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output signed [N-1:0] C
);
    
    wire signed [N:0] AN,BN,CN;

    assign AN = {A[N-1],A};
    assign BN = {B[N-1],B};
    assign CN = AN + BN;

    assign C = CN[N:1];
endmodule


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module tree_8 #(
    parameter N=32,
    parameter F=11
)(
    input[N-1:0] M1,M2,M3,M4,M5,M6,M7,M8,
    output[N-1:0] y
);

    wire[N-1:0] Soma1O,Soma2O,Soma3O,Soma4O,Soma5O,Soma6O,Soma7O;

    ADDER_SHIFT #(N) SUM_1 (.A(M1), .B(M2), .C(Soma1O));
    ADDER_SHIFT #(N) SUM_2 (.A(M3), .B(M4), .C(Soma2O));
    ADDER_SHIFT #(N) SUM_3 (.A(M5), .B(M6), .C(Soma3O));
    ADDER_SHIFT #(N) SUM_4 (.A(M7), .B(M8), .C(Soma4O));
    ADDER_SHIFT #(N) SUM_5(.A(Soma1O),.B(Soma2O), .C(Soma5O));
    ADDER_SHIFT #(N) SUM_6(.A(Soma3O),.B(Soma4O), .C(Soma6O));
    ADDER_SHIFT #(N) SUM_7(.A(Soma5O),.B(Soma6O), .C(Soma7O));
    assign y = {Soma7O[N-1],Soma7O[N-5:0],1'b0,1'b0,1'b0};
endmodule

module FIR_SFilter # (parameter N=16, parameter F = 14) (
    input wire clock,
    input wire reset,
    input wire [N-1:0] x_in,       // Entrada do filtro
    output wire [N-1:0] y_out      // Saída do filtro
);

    // Constantes em ponto fixo (ajustadas para Q16.11)
    wire [N-1:0] g =  16'h2000; //0.5
    wire [N-1:0] c = 16'h1333; // 0.3 em Q16.11

    // Registradores para armazenar valores anteriores de y
    wire [N-1:0] y_reg1, y_reg2;

    // Sinais intermediários
    wire [2*N-1:0] mult1, mult2;
    wire [N-1:0] mult1_trunc, mult2_trunc, sub1, sub2, result;

    // Instâncias de registros para os valores anteriores de y
    REG #(N) R1 (.clock(clock), .CL(reset), .A(result), .S(y_reg1));
    REG #(N) R2 (.clock(clock), .CL(reset), .A(y_reg1), .S(y_reg2));

    // Multiplicadores para g * y[n-1] e c * y[n-2]
    MULT_GEN #(N) Mult1 (.A(y_reg1), .B(g), .Y(mult1));
    MULT_GEN #(N) Mult2 (.A(y_reg2), .B(c), .Y(mult2));

    // Subtração: x_in - g * y[n-1] // usar o ext_gen para A ou usar o trunc_gen e trabalhar em N bits
    TRUN_GEN_C #(N/2,F) T_1 (.A(mult1),.Y(mult1_trunc));
    TRUN_GEN_C #(N/2,F) T_2 (.A(mult2),.Y(mult2_trunc));

    SUB_GEN #(N) Sub1 (.A(x_in), .B(mult1_trunc), .Y(sub1));
    // Subtração final: sub1 - c * y[n-2]
    SUB_GEN #(N) Sub2 (.A(sub1), .B(mult2_trunc), .Y(sub2));

    // Normalização do resultado
    assign result = sub2;

    // Conectando o resultado à saída
    assign y_out = result; //Usar trunc_gen

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module LMS_Direct_10taps #(
    parameter N =16,
    parameter F =14
)(
    input clock,reset,
    input[N-1:0] x,d,mi,
    output [N-1:0] e,
    output [N-1:0] y
);
    wire [N-1:0] erro_yn, yn;
    wire[N-1:0] Ro9,Ro8,Ro7,Ro6,Ro5,Ro4,Ro3,Ro2,Ro1,Ry,y_shift,erro,emi,W10,W9,W8,W7,W6,W5,W4,W3,W2,W1;
    wire[2*N-1:0] M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,y_trunc,SP2,SP1,Soma1O,em,MW1,WI1,MW2,WI2,MW3,WI3,MW4,WI4,MW5,WI5,MW6,WI6,MW7,WI7,MW8,WI8,MW9,WI9,MW10,WI10,WO10,WO9,WO8,WO7,WO6,WO5,WO4,WO3,WO2,WO1;

    // Esses registradores em sequência criam uma memória do sinal de entrada, pois demora 10 ciclos para x chegar em Ro9
    REG #(N) R1(.clock(clock),.CL(reset),.A(x),.S(Ro1));
    REG #(N) R2(.clock(clock),.CL(reset),.A(Ro1),.S(Ro2));
    REG #(N) R3(.clock(clock),.CL(reset),.A(Ro2),.S(Ro3));
    REG #(N) R4(.clock(clock),.CL(reset),.A(Ro3),.S(Ro4));
    REG #(N) R5(.clock(clock),.CL(reset),.A(Ro4),.S(Ro5));
    REG #(N) R6(.clock(clock),.CL(reset),.A(Ro5),.S(Ro6));
    REG #(N) R7(.clock(clock),.CL(reset),.A(Ro6),.S(Ro7));
    REG #(N) R8(.clock(clock),.CL(reset),.A(Ro7),.S(Ro8));
    REG #(N) R9(.clock(clock),.CL(reset),.A(Ro8),.S(Ro9));
    
    // ##############################################################################################
    /* Acho que esse é o W FILTER, isso em python seria:
        for i in range(1, len(self.a)):
            if n_tot > i:
                temp = temp - x_tot[n_tot - i] * self.a[i]
    onde a[i] = W[i]
    */
    MULT_GEN #(N) Mult1(.A(W1),.B(x),.Y(M1));
    MULT_GEN #(N) Mult2(.A(W2),.B(Ro1),.Y(M2));
    MULT_GEN #(N) Mult3(.A(W3),.B(Ro2),.Y(M3));
    MULT_GEN #(N) Mult4(.A(W4),.B(Ro3),.Y(M4));
    MULT_GEN #(N) Mult5(.A(W5),.B(Ro4),.Y(M5));
    MULT_GEN #(N) Mult6(.A(W6),.B(Ro5),.Y(M6));
    MULT_GEN #(N) Mult7(.A(W7),.B(Ro6),.Y(M7));
    MULT_GEN #(N) Mult8(.A(W8),.B(Ro7),.Y(M8));
    MULT_GEN #(N) Mult9(.A(W9),.B(Ro8),.Y(M9));
    MULT_GEN #(N) Mult10(.A(W10),.B(Ro9),.Y(M10));

    // temp = temp - x_tot[n_tot - i] * self.a[i] pode ser reescrito como temp - SOMATÓRIO dos MULT_GEN
    SUM_GEN #(2*N) SUM_tree2(.A(M1),.B(M2),.Y(SP1));
    tree_8 #(2*N)  AT2 (M3,M4,M5,M6,M7,M8,M9,M10,SP2);
    SUM_GEN #(2*N) SUM_10(.A(SP1),.B(SP2),.Y(Soma1O));
    //ISSO AQUI TA ESTRANHO, pq tava dando shift a esquerda? (código original)
    //Resposta (Vinicius): Por conta da linha 58, como estamos em ponto fixo a multiplicação de divisão gera um deslocamento em relação a F
    // (A << F) * (B << F) = (A * B) << (2 * F)
    //Então sempre depois dessas operações é necessário corrigir


    // Como temp = 0, inverte o resultado, isso no python seria o xp
    assign y_trunc = -1*Soma1O;

    // ##############################################################################################
    //Instância do filtro Sfilter

    TRUN_GEN_C #(N/2,F) T1 (.A(y_trunc),.Y(y_shift));
    FIR_SFilter Sfilter (.clock(clock),.reset(reset),.x_in(y_shift),.y_out(yn));


    // ##############################################################################################
    // erro
    SUM_GEN #(N) error_adder(.A(d),.B(yn),.Y(erro_yn));


    // ##############################################################################################
    // self.wfilter.update

    MULT_GEN #(N) Mult_mi (.A(erro_yn),.B(mi), .Y(em));
    TRUN_GEN_C #(N/2,F) T_mi (.A(em), .Y(emi));
    //Multiplicadores para Calculo de newCoef
    MULT_GEN2 #(N) Mult_we1(.A(emi) ,.B(x),.Y(MW1));
    SUM_GEN #(2*N) Sum_we1(.A(MW1),.B(WO1),.Y(WI1));
    MULT_GEN2 #(N) Mult_we2(.A(emi) ,.B(Ro1),.Y(MW2));
    SUM_GEN #(2*N) Sum_we2(.A(MW2),.B(WO2),.Y(WI2));
    MULT_GEN2 #(N) Mult_we3(.A(emi) ,.B(Ro2),.Y(MW3));
    SUM_GEN #(2*N) Sum_we3(.A(MW3),.B(WO3),.Y(WI3));
    MULT_GEN2 #(N) Mult_we4(.A(emi) ,.B(Ro3),.Y(MW4));
    SUM_GEN #(2*N) Sum_we4(.A(MW4),.B(WO4),.Y(WI4));
    MULT_GEN2 #(N) Mult_we5(.A(emi) ,.B(Ro4),.Y(MW5));
    SUM_GEN #(2*N) Sum_we5(.A(MW5),.B(WO5),.Y(WI5));
    MULT_GEN2 #(N) Mult_we6(.A(emi) ,.B(Ro5),.Y(MW6));
    SUM_GEN #(2*N) Sum_we6(.A(MW6),.B(WO6),.Y(WI6));
    MULT_GEN2 #(N) Mult_we7(.A(emi) ,.B(Ro6),.Y(MW7));
    SUM_GEN #(2*N) Sum_we7(.A(MW7),.B(WO7),.Y(WI7));
    MULT_GEN2 #(N) Mult_we8(.A(emi) ,.B(Ro7),.Y(MW8));
    SUM_GEN #(2*N) Sum_we8(.A(MW8),.B(WO8),.Y(WI8));
    MULT_GEN2 #(N) Mult_we9(.A(emi) ,.B(Ro8),.Y(MW9));
    SUM_GEN #(2*N) Sum_we9(.A(MW9),.B(WO9),.Y(WI9));
    MULT_GEN2 #(N) Mult_we10(.A(emi) ,.B(Ro9),.Y(MW10));
    SUM_GEN #(2*N) Sum_we10(.A(MW10),.B(WO10),.Y(WI10));

    // ##############################################################################################
    REG #(2*N) R_we1(.clock(clock),.CL(reset),.A(WI1),.S(WO1));
    TRUN_GEN_C #(N/2,F) T_we1(.A(WO1), .Y(W1));
    REG #(2*N) R_we2(.clock(clock),.CL(reset),.A(WI2),.S(WO2));
    TRUN_GEN_C #(N/2,F) T_we2(.A(WO2), .Y(W2));
    REG #(2*N) R_we3(.clock(clock),.CL(reset),.A(WI3),.S(WO3));
    TRUN_GEN_C #(N/2,F) T_we3(.A(WO3), .Y(W3));
    REG #(2*N) R_we4(.clock(clock),.CL(reset),.A(WI4),.S(WO4));
    TRUN_GEN_C #(N/2,F) T_we4(.A(WO4), .Y(W4));
    REG #(2*N) R_we5(.clock(clock),.CL(reset),.A(WI5),.S(WO5));
    TRUN_GEN_C #(N/2,F) T_we5(.A(WO5), .Y(W5));
    REG #(2*N) R_we6(.clock(clock),.CL(reset),.A(WI6),.S(WO6));
    TRUN_GEN_C #(N/2,F) T_we6(.A(WO6), .Y(W6));
    REG #(2*N) R_we7(.clock(clock),.CL(reset),.A(WI7),.S(WO7));
    TRUN_GEN_C #(N/2,F) T_we7(.A(WO7), .Y(W7));
    REG #(2*N) R_we8(.clock(clock),.CL(reset),.A(WI8),.S(WO8));
    TRUN_GEN_C #(N/2,F) T_we8(.A(WO8), .Y(W8));
    REG #(2*N) R_we9(.clock(clock),.CL(reset),.A(WI9),.S(WO9));
    TRUN_GEN_C #(N/2,F) T_we9(.A(WO9), .Y(W9));
    REG #(2*N) R_we10(.clock(clock),.CL(reset),.A(WI10),.S(WO10));
    TRUN_GEN_C #(N/2,F) T_we10(.A(WO10), .Y(W10));
    assign e=erro_yn;
    REG #(N) R_OUT(.clock(clock),.CL(reset),.A(y_shift),.S(y));

endmodule
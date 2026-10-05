// Truncation 
module TRUN_GEN_C #(
    parameter integer N = 16,
    parameter integer F = 14
)(
    input  wire [4*N-1:0] A,
    output wire [2*N-1:0] Y
);

    assign Y = {A[4*N-1],A[2*N +F -2: F]}; //== {2*N{1'b1}}) ? {N{1'b0}} : {A[4*N-1],A[2*N +F -2: F]}; //geral
endmodule 

// Adder
module SUM_GEN #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output reg signed [N-1:0] Y
);

    reg c_out;

    always @ (A or B) begin
        {c_out, Y}=A+B;
    end
endmodule

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

module MULT_GEN #(
    parameter integer N=16
)(
    input signed [N-1:0] A,
    input signed [N-1:0] B,
    output signed [2*N-1:0] Y
);
    assign Y = A * B;   
endmodule

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

    // Constantes em ponto fixo (ajustadas para Q1.11)
    wire [N-1:0] g = 16'h2000; //  0.5 * (2 ^ 14) = 0.5 * (16384) = 16'd8192 = 16'h2000 
    wire [N-1:0] c = 16'h1333; // 0.3 * (2 ^ 14) = 0.5 * (16384) = 16'd4915 = 16'h1333

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
    wire[N-1:0] Ry,y_shift,erro,emi;
    wire[2*N-1:0] y_trunc,SP2,SP1,Soma1O,em;
    wire[2*N-1:0] MW [0:9];
    wire[2*N-1:0] WI [0:9];
    wire[2*N-1:0] WO [0:9];


    wire [N-1:0] Ro [0:9];
    wire [N-1:0] W [0:9];
    wire [2*N-1:0] M [0:9];

    // Esses registradores em sequência criam uma memória do sinal de entrada, pois demora 10 ciclos para x chegar em Ro9
    genvar i;
    generate
        for (i = 0; i < 9; i = i + 1) begin : gen_reg
            REG #(N) R (
                .clock(clock),
                .CL(reset),
                .A(i == 0 ? x : Ro[i]),
                .S(Ro[i+1])
            );
        end
    endgenerate

    genvar k;
    generate
        for (k = 0; k < 10; k = k + 1) begin : gen_mul
            MULT_GEN #(N) Mult(
                .A(W[k]),
                .B(k == 0 ? x : Ro[k]),
                .Y(M[k])
            );
        end
    endgenerate


    SUM_GEN #(2*N) SUM_tree2(.A(M[0]),.B(M[1]),.Y(SP1));
    tree_8 #(2*N)  AT2 (M[2],M[3],M[4],M[5],M[6],M[7],M[8],M[9],SP2);
    SUM_GEN #(2*N) SUM_1(.A(SP1),.B(SP2),.Y(Soma1O));
    // AQUI COMO SOMAMOS 10 NUMEROS O RESULTADO PODE TER ATÉ 10 BITS DE PARTE INTEIRA

    // Como temp = 0, inverte o resultado, isso no python seria o xp
    assign y_trunc = -1*Soma1O;

    TRUN_GEN_C #(N/2,F) T1 (.A(y_trunc),.Y(y_shift));

    //Instância do filtro Sfilter
    FIR_SFilter Sfilter (.clock(clock),.reset(reset),.x_in(y_shift),.y_out(yn));


    // erro
    SUM_GEN #(N) error_adder(.A(d),.B(yn),.Y(erro_yn));

    //Multiplicadores para Calculo de newCoef
    MULT_GEN #(N) Mult_mi (.A(erro_yn),.B(mi), .Y(em));
    TRUN_GEN_C #(N/2,F) T_mi (.A(em), .Y(emi));
    

    genvar j;
    generate
        for (j = 0; j < 10; j = j + 1) begin : gen_coef_update
            MULT_GEN #(N) Mult_w(
                .A(emi),
                .B(j == 0 ? x : Ro[j]),
                .Y(MW[j])
            );

            SUM_GEN #(2*N) Sum_w(
                .A(MW[j]),
                .B(WO[j]),
                .Y(WI[j])
            );

            // ########################
            REG #(2*N) R_we(
                .clock(clock),
                .CL(reset),
                .A(WI[j]),
                .S(WO[j])
            );

            TRUN_GEN_C #(N/2,F) T_we(
                .A(WO[j]),
                .Y(W[j])
            );
        end
    endgenerate

    assign e=erro_yn;
    REG #(N) R_OUT(.clock(clock),.CL(reset),.A(y_shift),.S(y));
    
endmodule
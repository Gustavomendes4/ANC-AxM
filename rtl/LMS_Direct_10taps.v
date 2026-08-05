// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Truncation 
module TRUN_GEN_C(A, Y);
    parameter N = 16;
    parameter F = 11;
    input [4*N-1:0] A;
    output wire [2*N-1:0] Y;

    wire signed [4*N-1:0] abs_val;   // Valor absoluto
    wire signed [2*N-1:0] truncated; // Valor truncado

    assign truncated = {A[4*N-1], A[(2*F)+3:2*F],A[2*F-1:F]};
// Operador ternário para restaurar sinal ou zerar
    assign Y = (truncated == {2*N{1'b1}}) ? 0 : truncated;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Adder
module SUM_GEN(A,B,Y);
parameter N=16;
input signed [N-1:0] A,B;
output reg signed [N-1:0] Y;

reg c_out;
//carry calculado errado, vale apenas para positivos
always @ (A or B) begin
{c_out, Y}=A+B;
end
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

module DRUM
    # (parameter N=16, parameter L=4)
    (a, b, r);

    input [N-1:0] a;
    input [N-1:0] b;
    output [2*N-1:0] r;

    wire [N-1:0] a_temp;
    wire [N-1:0] b_temp;
    wire [2*N-1:0] r_temp;
    wire out_sign;

    DRUMu #(.N(N), .L(L)) U1 (.a(a_temp), .b(b_temp), .r(r_temp));

    assign a_temp = a[N-1] ? ~a + 1 : a;
    assign b_temp = b[N-1] ? ~b + 1 : b;
    assign out_sign = a[N-1] ^ b[N-1];
    assign r = out_sign ? ~ r_temp + 1 : r_temp;

endmodule

module DRUMu
    # (parameter N=16, parameter L=6)
    (a, b, r);

    input [N-1:0] a;
    input [N-1:0] b;
    output [2*N-1:0] r;

    wire [$clog2(N)-1:0] k1;
    wire [$clog2(N)-1:0] k2;
    wire [L-3:0] m;
    wire [L-3:0] n;
    wire [N-1:0] l1;
    wire [N-1:0] l2;
    wire [(L*2)-1:0] tmp;
    wire [$clog2(N)-1:0] p;
    wire [$clog2(N)-1:0] q;
    wire [$clog2(N):0]sum;
    wire [L-1:0] mm;
    wire [L-1:0] nn;

    DRUM_LOD_k #(.N(N)) u1 (.in_a(a), .out_a(l1));
    DRUM_LOD_k #(.N(N)) u2 (.in_a(b), .out_a(l2));

    DRUM_P_Encoder_k #(.N(N)) u3 (.in_a(l1), .out_a(k1));
    DRUM_P_Encoder_k #(.N(N)) u4 (.in_a(l2), .out_a(k2));

    DRUM_Mux_16_3_k #(.N(N), .L(L)) u5 (.in_a(a), .select(k1), .out(n));
    DRUM_Mux_16_3_k #(.N(N), .L(L)) u6 (.in_a(b), .select(k2), .out(m));

    DRUM_Barrel_Shifter_k #(.L(L), .N(N)) u7 (.in_a(tmp), .count(sum), .out_a(r));

    assign p = k1 > (L-1) ? k1 - (L-1) : 0;
    assign q = k2 > (L-1) ? k2 - (L-1) : 0;
    assign mm = k1 > (L-1) ? {1'b1, n, 1'b1} : a[L-1:0];
    assign nn = k2 > (L-1) ? {1'b1, m, 1'b1} : b[L-1:0];
    assign tmp = mm * nn;
    assign sum = p + q;

endmodule


module DRUM_LOD_k
    # (parameter N=16)
    (in_a, out_a);

    input [N-1:0]in_a;
    output reg [N-1:0]out_a;
    integer k,j;
    reg [N-1:0]w;

    always @ (*) begin
        out_a[N-1]=in_a[N-1];
        w[N-1]=in_a[N-1]?0:1;
        for (k=N-2;k>=0;k=k-1)
            begin
            w[k]=in_a[k]?0:w[k+1];
            out_a[k]=w[k+1]&in_a[k];
            end
    end

endmodule


module DRUM_P_Encoder_k
    # (parameter N=16)
    (in_a, out_a);

    input [N-1:0]in_a;
    output reg [$clog2(N)-1:0]out_a;
    integer i;

    always @ (*) begin
        out_a = 0;
        for (i=N-1; i>=0; i=i-1)
            if (in_a[i]) out_a = i[$clog2(N)-1:0];
    end

endmodule


module DRUM_Barrel_Shifter_k
    # (parameter N=16, parameter L=6)
    (in_a, count, out_a);

    input [$clog2(N):0]count;
    input [(L*2)-1:0]in_a;
    output [2*N-1:0]out_a;
    wire [2*N-1:0] tmp;

    assign tmp = {{((2*N)-(L*2)){1'b0}}, in_a};
    assign out_a=(tmp<<count);

endmodule


module DRUM_Mux_16_3_k
    #(parameter N=16, parameter L=6)
    (in_a, select, out);

    input [$clog2(N)-1:0]select;
    input [N-1:0]in_a;
    output reg [L-3:0]out;
    integer i;

    always @(*) begin
        out = 0;
        for (i = L;i<(N);i=i+1) begin :mux_gen_block
            if (select == i[$clog2(N)-1:0])
                out = in_a[i-1 -: L-2];
        end
    end

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//LOBA MULTIPLIER MAxPY
module LOBA
    # (parameter N=16, parameter L=4)
    (a, b, r);

    input [N-1:0] a;
    input [N-1:0] b;
    output [2*N-1:0] r;

    wire [N-1:0] a_temp;
    wire [N-1:0] b_temp;
    wire [2*N-1:0] r_temp;
    wire out_sign;

    LOBA0u #(.N(N), .L(L)) u1 (.a(a_temp), .b(b_temp), .r(r_temp));

    assign a_temp = a[N-1] ? ~a + 1 : a;
    assign b_temp = b[N-1] ? ~b + 1 : b;
    assign out_sign = a[N-1] ^ b[N-1];
    assign r = out_sign ? ~ r_temp + 1 : r_temp;

endmodule


module LOBA0u
    # (parameter N=16, parameter L=4)
    (a, b, r);

    input [N-1:0] a;
    input [N-1:0] b;
    output [2*N-1:0] r;

    wire [L-1:0] Ah;
    wire [L-1:0] Al;
    wire [$clog2(N)-1:0] k1a;
    wire [$clog2(N)-1:0] k2a;

    wire [L-1:0] Bh;
    wire [L-1:0] Bl;
    wire [$clog2(N)-1:0] k1b;
    wire [$clog2(N)-1:0] k2b;

    LOBA_SPLIT #(.N(N),.L(L)) u1 (.X(a), .Xh(Ah), .kh(k1a), .Xl(Al), .kl(k2a));
    LOBA_SPLIT #(.N(N),.L(L)) u2 (.X(b), .Xh(Bh), .kh(k1b), .Xl(Bl), .kl(k2b));

    assign r =
        ((Ah*Bh)<<(k1a+k1b-(2*(L-1))))
        ;
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module LOBA_SPLIT
    # (parameter N=16, parameter L=4)
    (X, Xh, Xl, kh, kl);

    input [N-1:0] X;
    output reg [L-1:0] Xh;
    output reg [L-1:0] Xl;
    output reg [$clog2(N)-1:0] kh;
    output reg [$clog2(N)-1:0] kl;

    wire [N-1:0] lobh;
    wire [N-1:0] lobl;
    reg [N-1:0] lower;
    genvar i;

    LOBA_LOB #(.N(N)) u1 (.x(X), .y(lobh));
    LOBA_LOB #(.N(N)) u2 (.x(lower), .y(lobl));

    LOBA_MUX #(.L(L), .N(N)) u3 (.in_a(X), .select(kh), .out(Xh));
    LOBA_MUX #(.L(L), .N(N)) u4 (.in_a(X), .select(kl), .out(Xl));

    LOBA_LOWER #(.N(N)) u5 (.in_a(X), .select(kh-L), .out(lower));

    generate
        for (i=N-1; i>=L-1; i=i-1) begin
            always @ (*) begin
                if (lobh[i] == 1) begin
                    kh <= i;
                end

                if (lobl[i] == 1) begin
                    kl <= i;
                end
            end
        end
    endgenerate
endmodule


module LOBA_MUX
    # (parameter N=16, parameter L=4)
    (in_a, select, out);

    input [$clog2(N)-1:0] select;
    input [N-1:0] in_a;
    output reg [L-1:0] out;
    integer i;

    always @ (*) begin
        out <= 0;
        for (i=L-1; i<(N); i=i+1) begin
            if (select == i) begin
                out <= in_a[i -: L];
            end
        end
    end

endmodule


module LOBA_LOWER
    #(parameter N=16)
    (in_a, select, out);

    input [$clog2(N)-1:0] select;
    input [N-1:0] in_a;
    output reg [N-1:0] out;
    genvar i;

    for (i=N-1; i>=0; i=i-1) begin
        always @ (*) begin
            if (select == i) begin
                out[N-1:i] <= 0;
                out[i:0] <= in_a[i:0];
            end
        end
    end

endmodule


module LOBA_LOB
    # (parameter N=16)
    (x, y);
    input [N-1:0] x;
    output reg [N-1:0] y;
    integer k;
    reg [N-1:0]w;
    always @ (*) begin
        y[N-1]=x[N-1];
        w[N-1]=x[N-1]?0:1;
        for (k=N-2;k>=0;k=k-1) begin
            w[k]=x[k]?0:w[k+1];
            y[k]=w[k+1]&x[k];
        end
    end
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// TruncZero adder MAxPy
module TruncZeroAdder #(
  parameter WIDTH=8,
  parameter K=5
)(
  input    [WIDTH-1:0] A,B,
  output   [WIDTH:0] OUT
);
  generate
    if (K == 0) begin
      assign OUT = A + B;
    end else begin
      assign OUT[WIDTH:K] = A[WIDTH-1:K] + B[WIDTH-1:K];
      assign OUT[K-1:0] = {K{1'b0}};
    end
  endgenerate
endmodule 

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// TruncOne adder MAxPy
module TruncOneAdder #(
    parameter WIDTH=8,
    parameter K=5
)(
    input    [WIDTH-1:0] A,B,
    output   [WIDTH:0] OUT
);
  generate
    if (K == 0) begin
      assign OUT = A + B;
    end else
    begin
      assign OUT[WIDTH:K] = A[WIDTH-1:K] + B[WIDTH-1:K];
      assign OUT[K-1:0] = {K{1'b1}};
    end
  endgenerate
endmodule 

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Copy adder MAxPy
module copyAdder #(
  parameter WIDTH=8,
  parameter K=5
)(

  input    [WIDTH-1:0] A,B,
  output   [WIDTH:0] OUT
);
  generate
    if (K == 0) begin
      assign OUT = A + B;
    end else begin
      assign OUT[WIDTH:K] = A[WIDTH-1:K] + B[WIDTH-1:K];
      assign OUT[K-1:0] = A[K-1:0];
    end
  endgenerate
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// LOA adder MAxPy
module LOAAdder #(
    parameter WIDTH=8,
    parameter K=5
    )
    (
    input    [WIDTH-1:0] A,B,
    output   [WIDTH:0] OUT
    );
  
  generate
    if (K == 0) begin
      assign OUT = A + B;
    end else begin
      assign OUT[WIDTH:K] = A[WIDTH-1:K] + B[WIDTH-1:K];
      assign OUT[K-1:0] = A[K-1:0] | B[K-1:0];
    end
  endgenerate
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Subtractor
module SUB_GEN(A,B,Y);
parameter N=16;
input signed [N-1:0] A,B;
output[N-1:0] Y;

assign Y = A - B;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Register with synchronous clear
module REG(clock,CL,A,S);
parameter N=16;
input clock, CL;
input[N-1:0] A;
output reg[N-1:0] S;

always @(posedge clock)
begin
if (CL) S = {N{1'b0}};
else S = A;
end
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Register with synchronous clear and load
module REG_GEN(clock,LD,CL,A,S);
parameter N=16;
input clock,LD, CL;
input[N-1:0] A;
output reg[N-1:0] S;

//always @ (clock)
always @ (posedge clock or posedge CL)
begin
if (CL) S <= {N{1'b0}};
else if (LD) S<=A;
end 
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//MUX8x1
module MUX8_1_GEN(A,B,C,D,E,F,G,H,SEL,Y);
parameter N=16;
input[N-1:0] A,B,C,D,E,F,G,H;
input[2:0] SEL;
output[N-1:0] Y;

assign Y = SEL ==3'b000 ? A:
           SEL ==3'b001 ? B:
	   SEL ==3'b010 ? C:
	   SEL ==3'b011 ? D:
	   SEL ==3'b100 ? E:
           SEL ==3'b101 ? F:
           SEL ==3'b110 ? G:
           H;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//MUX2x1
module MUX2_1_GEN(A,B,SEL,Y);
parameter N=16;
input[N-1:0] A,B;
input SEL;
output[N-1:0] Y;

assign Y = SEL ==1'b0 ? A:
           B;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//mux4x1
module MUX4_1_GEN(A,B,C,D,SEL,Y);
parameter N=16;
input[N-1:0] A,B,C,D;
input[1:0] SEL;
output[N-1:0] Y;

assign Y = SEL ==2'b00 ? A:
           SEL ==2'b01 ? B:
	   SEL ==2'b10 ? C:
	   D;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Multiplier
module MULT_GEN(A,B,Y);
parameter N=16;
input signed [N-1:0] A,B;
output[2*N-1:0] Y;

assign Y = A * B;

endmodule

//Multiplier
module MULT_GEN2(A,B,Y);
parameter N=16;
input signed [N-1:0] A,B;
output[2*N-1:0] Y;

assign Y = A * B;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Logical extender
module EXT_G(A,Y); 
parameter N=16;
parameter F=11;
input[2*N-1:0] A;
output[4*N-1:0] Y;


wire[F-1:0] VETOR = {F{1'b0}}; //geral
wire[2*N-1-F:0] VETOR1 = {2*N-F{A[2*N-1]}};  //geral

assign Y = {VETOR1,A,VETOR};
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Adder Tree adder
module ADDER_SHIFT(A,B,C);
parameter N=16;
input signed [N-1:0] A,B;
output[N-1:0] C;
 
wire signed [N:0] AN,BN,CN;

assign AN = {A[N-1],A};
assign BN = {B[N-1],B};
assign CN = AN + BN;

assign C = CN[N:1];

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module dopt_GEN(divisor,inv_div_dopt);
parameter N=16;
input[2*N-1:0] divisor;
output[2*N-1:0] inv_div_dopt;

   reg[2*N-1:0] dopt; // valor de resposta do inverso do divisor
   reg[2*N-1:0] dopt_saida; // valor de resposta da segunda aproximacao que melhora o resultado
   wire[2*N+1:0] test_dopt, test_div; // valor de resposta da segunda aproximacao que melhora o resultado
   wire[N-2:0] vetor =  {N-1{1'b0}};
   wire[N-1:0] vetor1 = {N{1'b0}};
   wire[2*N-1:0] vetor2 =  {2*N{1'b0}};

assign test_dopt = {2'b00,divisor};

integer i;
     always @ (test_dopt)
        begin         
           for(i=2;i <=2*N+1;i=i+1) 
		begin          
                	if (test_dopt[i]==1'b1)
				begin
				   dopt = {2*N{1'b0}};
				   dopt[2*N+1-i] = 1'b1;
				end
	                else dopt[2*N+1-i] = 1'b0;
   
		 end 
	end

assign test_div = {2'b00,dopt};
   integer j;
 always @ (test_div or divisor)
     begin
     if (divisor == vetor2) dopt_saida = {vetor,1'b1,vetor1};
     else 
	begin
	dopt_saida = vetor2;
	for(j=2;j<=2*N-1;j=j+1)
		begin
		         if (test_div[j]== 1'b1)
				begin
		        	dopt_saida[j] = 1'b1;
			        dopt_saida[j-1] = ~(divisor[2*N+1-j-1]);
				dopt_saida[j-2] = ~(divisor[2*N+1-j-2]);
			end
	     		else 
			begin
				if (test_div[j+1] == 1'b1 || test_div[j+2] == 1'b1) dopt_saida[j] = ~(divisor[2*N+1-j]);
		    		else dopt_saida[j] = 1'b0;
			end	
		 end    		  
	end
    end

   assign inv_div_dopt = dopt_saida;
    endmodule

module div_goldshimit_GEN(numerador,divisor,quociente);
parameter N=16;
parameter F=10;
input[2*N-1:0] numerador, divisor;
output[2*N-1:0]	quociente;

        wire[2*N-1:0] inv; // valor de resposta do inverso do divisor
	wire[2*N-1:0] dois_menos_erro0, dois_menos_erro1,sum;
	wire[2*N-1:0] divisoraux,numeradoraux,quocienteaux,quocienteaux1; 
	wire[4*N-1:0]  mult0_resp, mult0_erro;
	wire[4*N-1:0]  mult1_resp, mult1_erro, mult2_resp;
	wire[2*N-1:0]  VETOR, UM;
	wire sinal;
	
assign sinal = divisor[2*N-1] ^ numerador[2*N-1];

assign divisoraux   = divisor[2*N-1] == 1'b1 ? (~divisor + 1'b1):
               divisor;
assign numeradoraux = numerador[2*N-1] == 1'b1 ? (~numerador + 1'b1):
	        numerador;

assign VETOR[2*N-1:N+3] ={N-3{1'b0}};
assign VETOR[N+2] =1'b1;
assign VETOR[N+1:0] ={N+2{1'b0}};

assign UM[2*N-1:1] = {2*N-1{1'b0}};
assign UM[0] = 1'b1;


    // Instansiar o inverso do divisor module (dut)  
        dopt_GEN #(N) dut (divisoraux, inv);

assign 		mult0_resp = numeradoraux * inv;
assign		mult0_erro = divisoraux * inv;
assign		dois_menos_erro0 = VETOR - mult0_erro[3*N:N+1]; 
		
assign		mult1_resp = mult0_resp[3*N:N+1] * dois_menos_erro0;
assign		mult1_erro = mult0_erro[3*N:N+1] * dois_menos_erro0;
assign		dois_menos_erro1 = VETOR - mult1_erro[3*N:N+1]; 
		
assign	    mult2_resp = mult1_resp[3*N:N+1] * dois_menos_erro1;
		
assign	quocienteaux =mult2_resp[4*N+1-F:(2*N - F)+2];

assign quociente = sinal ==1'b1 ? (~quocienteaux + 1'b1): 
              quocienteaux;

endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//NLMS ARCHITECTURE
module NLMS_4Cycles (clock,x,e,clear,load1,load2,load5,sel4,sel5,sel1,sel3,y,Xf);
parameter N=16;
parameter F=11;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load5,sel4,sel5;
input[1:0] sel1,sel3;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] W140,MUX4O,W040,MUX5O,SUMO,X1O,X2O;
wire[N-1:0] R2O, R3O,NSUMO;
wire[N-1:0] R1O,MUX1O,MUX3O,R1O1;
wire[N-1:0] zero = {N{1'b0}};

REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R11 (clock,load1,clear,R1O,R1O1);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO,R2O);
REG_GEN #(N) R3 (clock,load2,clear,NSUMO,R3O);
MUX4_1_GEN #(N) MUX1 (e,R2O,x,zero,sel1,MUX1O);
MUX4_1_GEN #(N) MUX3 (R3O,e,R1O,zero,sel3,MUX3O);
MUX2_1_GEN #(2*N) MUX4 (X1O,W140,sel4,MUX4O);
MUX2_1_GEN #(2*N) MUX5 (W040,X2O,sel5,MUX5O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
MULT_GEN #(N) X2_App (R1O,MUX3O,X2O);
SUM_GEN #(2*N) S1_App (.A(MUX4O),.B(MUX5O),.Y(SUMO));
TRUN_GEN_C #(N/2,F) T1 (SUMO,NSUMO);
EXT_G #(N/2,F) E1 (R3O,W140);
EXT_G  #(N/2,F) E2 (R2O,W040);
assign y = NSUMO;
assign Xf=R1O1;
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//LMS architecture
module LMS_3Cycles(clock,x,e,clear,load1,load2,load4,sel1,sel3,sel4,sel5,y,Xf);
parameter N=16;
parameter F=8;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load4,sel1,sel3,sel4,sel5;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] W140,MUX4O,W040,MUX5O,SUMO,X1O,X2O;
wire[N-1:0] R2O, R3O,NSUMO;
wire[N-1:0] R1O,R1O1,MUX1O,MUX3O;

REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R11 (clock,load1,clear,R1O,R1O1);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO,R2O);
REG_GEN #(N) R3 (clock,load2,clear,NSUMO,R3O);
MUX2_1_GEN #(N) MUX1  (e,R2O,sel1,MUX1O);
MUX2_1_GEN #(N) MUX2  (R3O,e,sel3,MUX3O);
MUX2_1_GEN #(2*N) MUX3  (X1O,W140,sel4,MUX4O);
MUX2_1_GEN #(2*N) MUX4  (W040,X2O,sel5,MUX5O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
MULT_GEN #(N) X2_App (R1O,MUX3O,X2O);
SUM_GEN #(2*N) S1_App (.A(MUX4O),.B(MUX5O),.Y(SUMO));
TRUN_GEN_C #(N/2,F) T1 (SUMO,NSUMO);
EXT_G #(N/2,F) E1 (R3O,W140);
EXT_G #(N/2,F) E2 (R2O,W040);
assign y = NSUMO;
assign Xf=R1O1;
endmodule

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Fast NLMS architecture
module NLMS_3Cycles (clock,x,e,clear,load1,load2,load5,sel4,sel5,sel1,sel3,y,Xf);
parameter N=16;
parameter F=11;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load5,sel4,sel5;
input[1:0] sel1,sel3;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] W140,MUX4O,W040,SUMO1,SUMO2,X1O,X2O;
wire[N-1:0] R2O,R3O,NSUMO2,NSUMO1;
wire[N-1:0] R1O,MUX1O,MUX3O,R1O1;
wire[N-1:0] zero = {N{1'b0}};

REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R11 (clock,load1,clear,R1O,R1O1);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO1,R2O);
REG_GEN #(N) R3 (clock,load2,clear,NSUMO2,R3O);
MUX4_1_GEN #(N) MUX1 (e,R2O,x,zero,sel1,MUX1O);
MUX4_1_GEN #(N) MUX3 (R3O,e,R1O,zero,sel3,MUX3O);
MUX2_1_GEN #(2*N) MUX4 (X1O,W140,sel4,MUX4O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
MULT_GEN #(N) X2_App (R1O,MUX3O,X2O);
SUM_GEN #(2*N) S1_App (.A(W040),.B(X1O),.Y(SUMO1));
SUM_GEN #(2*N) S2_App (.A(MUX4O),.B(X2O),.Y(SUMO2));
TRUN_GEN_C #(N/2,F) T1 (SUMO1,NSUMO1);
TRUN_GEN_C #(N/2,F) T2 (SUMO2,NSUMO2);
EXT_G #(N/2,F) E1 (R3O,W140);
EXT_G  #(N/2,F) E2 (R2O,W040);
assign y = NSUMO2;
assign Xf=R1O1;
endmodule


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//Fast LMS architecture
module LMS_2Cycles(clock,x,e,clear,load1,load2,load4,sel1,sel3,sel4,sel5,y,Xf);
parameter N=16;
parameter F=8;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load4,sel1,sel3,sel4,sel5;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] W140,MUX4O,W040,SUMO1,SUMO2,X1O,X2O;
wire[N-1:0] R2O,R3O,NSUMO2,NSUMO1;
wire[N-1:0] R1O,R1O1,MUX1O,MUX3O;

REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R11 (clock,load1,clear,R1O,R1O1);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO1,R2O);
REG_GEN #(N) R3 (clock,load2,clear,NSUMO2,R3O);
MUX2_1_GEN #(N) MUX1  (e,R2O,sel1,MUX1O);
MUX2_1_GEN #(N) MUX2  (R3O,e,sel3,MUX3O);
MUX2_1_GEN #(2*N) MUX3  (X1O,W140,sel4,MUX4O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
MULT_GEN #(N) X2_App (R1O,MUX3O,X2O);
SUM_GEN #(2*N) S1_App (.A(W040),.B(X1O),.Y(SUMO1));
SUM_GEN #(2*N) S2_App (.A(MUX4O),.B(X2O),.Y(SUMO2));
TRUN_GEN_C #(N/2,F) T1 (SUMO1,NSUMO1);
TRUN_GEN_C #(N/2,F) T2 (SUMO2,NSUMO2);
EXT_G #(N/2,F) E1 (R3O,W140);
EXT_G #(N/2,F) E2 (R2O,W040);
assign y = NSUMO2;
assign Xf=R1O1;
endmodule


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/*module LMS_1tap(clock,x,e,clear,load1,load2,load4,sel1,sel3,sel4,sel5,y,Xf);
parameter N=16;
parameter F=8;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load4,sel1,sel3,sel4,sel5;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] MUX4O,W040,SUMO1,X1O,zero;
wire[N-1:0] R2O,NSUMO1;
wire[N-1:0]R1O,MUX1O;
wire[N-1:0] zero = {N{1'b0}};

REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO1,R2O);
MUX2_1_GEN #(N) MUX1  (e,R2O,sel1,MUX1O);
MUX2_1_GEN #(2*N) MUX3  (W040,zero,sel4,MUX4O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
SUM_GEN #(2*N) S1_App (.A(MUX4O),.B(X1O),.Y(SUMO1));
TRUN_GEN_C #(N/2,F) T1 (SUMO1,NSUMO1);
EXT_G #(N/2,F) E2 (R2O,W040);
assign y = NSUMO1;
assign Xf=R1O;
endmodule
*/
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module NLMS_1tap (clock,x,e,clear,load1,load2,load5,sel4,sel5,sel1,sel3,y,Xf);
parameter N=16;
parameter F=11;
input clock;
input[N-1:0] x,e;
input clear,load1,load2,load5,sel4,sel5;
input[1:0] sel1,sel3;
output[N-1:0] y;
output[N-1:0] Xf;

wire[2*N-1:0] MUX4O,W040,SUMO1,X1O;
wire[N-1:0] R2O,NSUMO1;
wire[N-1:0] R1O,MUX1O;
wire[N-1:0] zeroN = {N{1'b0}};
wire[2*N-1:0] zero2N = 2*{N{1'b0}};


REG_GEN #(N) R1 (clock,load1,clear,x,R1O);
REG_GEN #(N) R2 (clock,load1,clear,NSUMO1,R2O);
MUX4_1_GEN #(N) MUX1 (e,R2O,x,zeroN,sel1,MUX1O);
MUX2_1_GEN #(2*N) MUX4 (zero2N,W040,sel4,MUX4O);
MULT_GEN #(N) X1_App (x,MUX1O,X1O);
SUM_GEN #(2*N) S1_App (.A(MUX4O),.B(X1O),.Y(SUMO1));
TRUN_GEN_C #(N/2,F) T1 (SUMO1,NSUMO1);
EXT_G #(N/2,F) E2 (R2O,W040);
assign y = NSUMO1;
assign Xf=R1O;
endmodule


module tree_8 (M1,M2,M3,M4,M5,M6,M7,M8, y);
parameter N=32;
parameter F=11;
input[N-1:0] M1,M2,M3,M4,M5,M6,M7,M8;
output[N-1:0] y;


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



module LMS_Direct_10taps (clock,reset,x,d,mi,e,y);
parameter N =16;
parameter F =14;
input clock,reset;
input[N-1:0] x,d,mi;
output [N-1:0] e;
output [N-1:0] y;

wire [N-1:0] erro_yn, yn;
wire[N-1:0] Ro9,Ro8,Ro7,Ro6,Ro5,Ro4,Ro3,Ro2,Ro1,Ry,y_shift,erro,emi,W10,W9,W8,W7,W6,W5,W4,W3,W2,W1;
wire[2*N-1:0] M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,y_trunc,SP2,SP1,Soma1O,em,MW1,WI1,MW2,WI2,MW3,WI3,MW4,WI4,MW5,WI5,MW6,WI6,MW7,WI7,MW8,WI8,MW9,WI9,MW10,WI10,WO10,WO9,WO8,WO7,WO6,WO5,WO4,WO3,WO2,WO1;

REG #(N) R1(.clock(clock),.CL(reset),.A(x),.S(Ro1));
REG #(N) R2(.clock(clock),.CL(reset),.A(Ro1),.S(Ro2));
REG #(N) R3(.clock(clock),.CL(reset),.A(Ro2),.S(Ro3));
REG #(N) R4(.clock(clock),.CL(reset),.A(Ro3),.S(Ro4));
REG #(N) R5(.clock(clock),.CL(reset),.A(Ro4),.S(Ro5));
REG #(N) R6(.clock(clock),.CL(reset),.A(Ro5),.S(Ro6));
REG #(N) R7(.clock(clock),.CL(reset),.A(Ro6),.S(Ro7));
REG #(N) R8(.clock(clock),.CL(reset),.A(Ro7),.S(Ro8));
REG #(N) R9(.clock(clock),.CL(reset),.A(Ro8),.S(Ro9));
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
//ORIGINAL//tree_2 #(2*N)  AT1 (M1,M2,SP1);
//ERROR//ADDER_SHIFT #(2*N) SUM_tree2 (.A(M1), .B(M2), .C(SP1));
SUM_GEN #(2*N) SUM_tree2(.A(M1),.B(M2),.Y(SP1));
tree_8 #(2*N)  AT2 (M3,M4,M5,M6,M7,M8,M9,M10,SP2);
//ERROR//ADDER_SHIFT #(2*N) SUM_1(.A(SP1),.B(SP2),.C(Soma1O));
SUM_GEN #(2*N) SUM_10(.A(SP1),.B(SP2),.Y(Soma1O));
//ISSO AQUI TA ESTRANHO, pq tava dando shift a esquerda?
//assign y_shift = {Soma1O[2*N-1],Soma1O[2*N-3:0],1'b0};

//COLOCAR O A INVERSÃO ANTES DO TRUNC É NECESSÁRIA PARA FUNCIONAR, MAS ISSO DA ERRO

assign y_trunc = -1*Soma1O;
//SUM_GEN #(2*N) SUM_INV(.A(~Soma1O),.B(0000000000000001),.Y(y_trunc));
TRUN_GEN_C #(N/2,F) T1 (.A(y_trunc),.Y(y_shift));
//y(n) = (-1)*(a_0 x(n) + a_1 x(n-1) + ...), negação do sinal
//assign y_shift = -1*y_trunc;
//INSTANCIAS RETIRADAS
//REG #(N) R_Y (.clock(clock),.CL(reset),.A(y_shift),.S(Ry));
//Colocar Sfilter e atualizar calculo do erro 
//Instância do filtro Sfilter
FIR_SFilter Sfilter (.clock(clock),.reset(reset),.x_in(y_shift),.y_out(yn));
SUM_GEN #(N) error_adder(.A(d),.B(yn),.Y(erro_yn));
//SUB_GEN #(N) SUB1 (.A(d),.B(yn),.Y(erro_yn));
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
//--------------------------------------------------------
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
//REG #(N) R_OUT(.clock(clock),.CL(reset),.A(yn),.S(y));
//assign y=y_shift;
endmodule
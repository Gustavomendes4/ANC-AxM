module AND_N #(parameter N=2)(
  input wire [N-1:0] in,
  output wire out
);

  assign out = &in;

endmodule

module OR_N #(parameter N=2)(
  input wire [N-1:0] in,
  output wire out
);

  assign out = |in;

endmodule


module LEADING_ONE_BIT #(parameter N=16) (input [N-1:0] in_a,input [N-1:0] L, output wire [N-1:0] out_a);
  
    wire out_and[N-1:0][N-1:0];//VETOR DE SAÍDAS DE AND GRANDE O SUFICIENTE PARA A QUANTIDADE DE ANDS
    wire [N-2:0] out_or;

        //genvar g,k;
        generate 
        genvar g,k;
        for (k= 0;  k<= N-1 ; k= k+1)begin //k linha
            for(g = 0; g <= N-1-k ; g =g+1) begin //g coluna
                  if(g==0) begin
                     if(k==0) begin//gera o primeiro and da primeira linha
                            AND_N #(k+2) and_inst({in_a[N-1],L[N-1]}, out_and[k][g+k]);
                      end
                     else begin//gera o primeiro and das demais linhas
                            AND_N #(k+2) and_inst({~in_a[N-1:N-k], in_a[N-1-k],L[N-1]}, out_and[k][g+k]);
                      end
                  end
                  else begin
                        if(k==0) begin //gera os Ands subsequentes da primeira linha
                              AND_N #(k+3) and_inst({in_a[N-1],in_a[N-1-g],L[N-1-g]}, out_and[k][g+k]);
                            end
                         else begin //gera os Ands subsequentes das demais linhas
                              AND_N #(k+3) and_inst({~in_a[N-1:N-k], in_a[N-1-k], in_a[N-1-k-g],L[N-1-g]}, out_and[k][g+k]);
                         end
                  end
                  
           end
        end
  
        endgenerate
    
    //padrão de OR criados na mão
    OR_N #(N-14) OR_14({out_and[0][1], out_and[1][1]}, out_or[14]);
    OR_N #(N-13) OR_13({out_and[0][2], out_and[1][2], out_and[2][2]},out_or[13]);
    OR_N #(N-12) OR_12({out_and[0][3], out_and[1][3], out_and[2][3], out_and[3][3]},out_or[12]);
    OR_N #(N-11) OR_11({out_and[0][4],out_and[1][4], out_and[2][4], out_and[3][4],out_and[4][4]},out_or[11]);
    OR_N #(N-10) OR_10({out_and[0][5],out_and[1][5], out_and[2][5], out_and[3][5], out_and[4][5],out_and[5][5]},out_or[10]);
    OR_N #(N-9) OR_9({out_and[0][6],out_and[1][6], out_and[2][6], out_and[3][6], out_and[4][6], out_and[5][6],out_and[6][6]},out_or[9]);
    OR_N #(N-8) OR_8({out_and[0][7],out_and[1][7], out_and[2][7], out_and[3][7], out_and[4][7], out_and[5][7],out_and[6][7],out_and[7][7]},out_or[8]);
    OR_N #(N-7) OR_7({out_and[0][8],out_and[1][8], out_and[2][8], out_and[3][8], out_and[4][8],  out_and[5][8],out_and[6][8],out_and[7][8],out_and[8][8]},out_or[7]);
    OR_N #(N-6) OR_6({out_and[0][9],out_and[1][9], out_and[2][9], out_and[3][9], out_and[4][9],  out_and[5][9],out_and[6][9],out_and[7][9],out_and[8][9],out_and[9][9]},out_or[6]);
    OR_N #(N-5) OR_5({out_and[0][10],out_and[1][10], out_and[2][10], out_and[3][10], out_and[4][10],  out_and[5][10],out_and[6][10],out_and[7][10],out_and[8][10],out_and[9][10],out_and[10][10]},out_or[5]);
    OR_N #(N-4) OR_4({out_and[0][11],out_and[1][11], out_and[2][11], out_and[3][11], out_and[4][11],  out_and[5][11],out_and[6][11],out_and[7][11],out_and[8][11],out_and[9][11],out_and[10][11],out_and[11][11]},out_or[4]);
    OR_N #(N-3) OR_3({out_and[0][12],out_and[1][12], out_and[2][12], out_and[3][12], out_and[4][12],  out_and[5][12],out_and[6][12],out_and[7][12],out_and[8][12],out_and[9][12],out_and[10][12],out_and[11][12],out_and[12][12]},out_or[3]);
    OR_N #(N-2) OR_2({out_and[0][13],out_and[1][13], out_and[2][13], out_and[3][13], out_and[4][13],  out_and[5][13],out_and[6][13],out_and[7][13],out_and[8][13],out_and[9][13],out_and[10][13],out_and[11][13],out_and[12][13],out_and[13][13]},out_or[2]);
    OR_N #(N-1) OR_1({out_and[0][14],out_and[1][14], out_and[2][14], out_and[3][14], out_and[4][14],  out_and[5][14],out_and[6][14],out_and[7][14],out_and[8][14],out_and[9][14],out_and[10][14],out_and[11][14],out_and[12][14],out_and[13][14],out_and[14][14]},out_or[1]);
    OR_N #(N) OR_0({out_and[0][15],out_and[1][15], out_and[2][15], out_and[3][15], out_and[4][15],  out_and[5][15],out_and[6][15],out_and[7][15],out_and[8][15],out_and[9][15],out_and[10][15],out_and[11][15],out_and[12][15],out_and[13][15],out_and[14][15],out_and[15][15]},out_or[0]);

    assign out_a[N-1:0] = {out_and[0][0],out_or[N-2:0]};//ordem dos OR ao contrário

endmodule

module LOB #(parameter N=16) (A, B, L ,NumA, NumB);

    input [N-1:0] A;
    input [N-1:0] B;
    input [N-1:0] L;
    output [N-1:0] NumA;
    output [N-1:0] NumB;

    wire [N-1:0] A_lead;
    wire [N-1:0] B_lead;

    LEADING_ONE_BIT #(N) lob1 (.in_a(A),.L(L), .out_a(A_lead));
    LEADING_ONE_BIT #(N) lob2 (.in_a(B),.L(L), .out_a(B_lead));

    assign NumA = A_lead;
    assign NumB = B_lead;

endmodule

module Reconfig_ApproximateM (a, b, l, p); //(a, b, l, p);

    parameter N=16;
    input  [N-1:0] a;
    input  [N-1:0] b;
    input  [N-1:0] l;
    //input clk;
    //input rst;
    output wire [2*N-1:0] p;

    wire [N-1:0] opA;
    wire [N-1:0] opB;

    wire [N-1:0] reg_a; // Registrador de entrada
    wire [N-1:0] reg_b; // Registrador de entrada
    //reg [N-1:0] reg_a0; // Registrador de entrada
    //reg [N-1:0] reg_b0; // Registrador de entrada
    wire [2*N-1:0] reg_p; // Registrador de saída
    //reg [2*N-1:0] reg_p0; // Registrador de saída

    //wire [N-1:0] A_;
    //wire [N-1:0] B_;
    wire [2*N-1:0] P_;

    // Implementar complemento de 2 para a entrada a se for negativa
    //assign A_ = (a[N-1] == 1'b1) ? (~a + 1'b1) : a;
    // Implementar complemento de 2 para a entrada b se for negativa
    //assign B_ = (b[N-1] == 1'b1) ? (~b + 1'b1) : b;
       // Implementar complemento de 2 para a entrada a se for negativa
  /*  always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_a0 <= {N{1'b0}};
        end else begin
            reg_a0 <= a;
        end
    end

    assign reg_a = (reg_a0[N-1] == 1'b1) ? (~reg_a0 + 1'b1) : reg_a0;
    // Implementar complemento de 2 para a entrada b se for negativa
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_b0 <= {N{1'b0}};
        end else begin
            reg_b0 <=  b;
        end
    end
   
    
    assign reg_b = (reg_b0[N-1] == 1'b1) ? (~reg_b0 + 1'b1) : reg_b0;

    */

    assign reg_a = (a[N-1] == 1'b1) ? (~a + 1'b1) : a;
    assign reg_b = (b[N-1] == 1'b1) ? (~b + 1'b1) : b;
    
    LOB #(N) lob_4 (.A(reg_a), .B(reg_b),.L(l) ,.NumA(opA), .NumB(opB));
    

    assign P_= opA*opB;

    //assign reg_p = ((reg_a0[N-1] ^ reg_b0[N-1]) == 1'b1) ? (~P_ + 1'b1) : P_;
   
   /* always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_p0 <= {2*N{1'b0}};
        end else begin
            reg_p0 <= reg_p;
        end
    end
*/    
    
    //assign p = reg_p;

    assign p = ((a[N-1] ^ b[N-1])== 1'b1) ? (~P_ + 1'b1): P_; 

endmodule

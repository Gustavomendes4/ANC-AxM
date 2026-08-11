module ANC_APPROX # (parameter N=16, parameter F = 14)(
    input clock,
    input reset,
    input [N-1:0] x_in,  // Entrada do sistema
    input [N-1:0] dn,L,    // Sinal desejado externo
    input [N-1:0] mi,    // Taxa de aprendizado
    output [N-1:0] en,   // Sinal de erro
    output [N-1:0] out  // Sinal (saída do W_filter)
);
    // Sinais intermediários
    wire [N-1:0] xp;     // Saída do filtro W_filter
   // wire [N-1:0] error;  // Sinal de erro

    // Instância do filtro adaptativo (W_filter)
   LMS_Direct_10taps_approxim W_filter (
        .clock(clock),
        .reset(reset),
        .x(x_in),      // Entrada principal
        .d(dn),
        .L(L),        // Sinal desejado externo
        .mi(mi),       // Taxa de aprendizado
        .e(en),     // Erro de saída
        .y(xp)         // Saída do filtro adaptativo
    );
    assign out = xp;   // Saída intermediária para anál

endmodule

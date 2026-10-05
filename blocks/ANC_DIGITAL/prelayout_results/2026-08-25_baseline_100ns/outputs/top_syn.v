/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R) NXT
// Version   : W-2024.09-SP5-4
// Date      : Tue Aug 25 00:58:05 2026
/////////////////////////////////////////////////////////////


module REG_N16 ( clock, CL, A, S );
  input [15:0] A;
  output [15:0] S;
  input clock, CL;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n54, n55;

  \**SEQGEN**  \S_reg[15]  ( .clear(1'b0), .preset(1'b0), .next_state(n1), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[15]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[14]  ( .clear(1'b0), .preset(1'b0), .next_state(n2), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[14]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[13]  ( .clear(1'b0), .preset(1'b0), .next_state(n3), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[13]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[12]  ( .clear(1'b0), .preset(1'b0), .next_state(n4), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[12]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[11]  ( .clear(1'b0), .preset(1'b0), .next_state(n5), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[11]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[10]  ( .clear(1'b0), .preset(1'b0), .next_state(n6), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[10]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[9]  ( .clear(1'b0), .preset(1'b0), .next_state(n7), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[9]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[8]  ( .clear(1'b0), .preset(1'b0), .next_state(n8), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[8]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(n9), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[7]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(n10), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[6]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(n11), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[5]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(n12), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[4]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(n13), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[3]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(n14), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[2]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(n15), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[1]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(n16), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[0]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  SELECT_OP C26 ( .DATA1({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .DATA2(A), .CONTROL1(n55), 
        .CONTROL2(n54), .Z({n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, 
        n13, n14, n15, n16}) );
  GTECH_BUF B_0 ( .A(CL), .Z(n55) );
  GTECH_BUF B_1 ( .A(n17), .Z(n54) );
  GTECH_NOT I_0 ( .A(CL), .Z(n17) );
endmodule


module MULT_GEN_N16 ( A, B, Y );
  input [15:0] A;
  input [15:0] B;
  output [31:0] Y;


  MULT_TC_OP mult_110 ( .A(A), .B(B), .Z(Y) );
endmodule


module SUM_GEN_N32 ( A, B, Y );
  input [31:0] A;
  input [31:0] B;
  output [31:0] Y;


  ADD_TC_OP add_64 ( .A(A), .B(B), .Z(Y) );
endmodule


module ADDER_SHIFT_N32 ( A, B, C );
  input [31:0] A;
  input [31:0] B;
  output [31:0] C;

  wire   SYNOPSYS_UNCONNECTED__0;

  ADD_TC_OP add_140 ( .A(A), .B(B), .Z({C, SYNOPSYS_UNCONNECTED__0}) );
endmodule


module tree_8_N32 ( M1, M2, M3, M4, M5, M6, M7, M8, y );
  input [31:0] M1;
  input [31:0] M2;
  input [31:0] M3;
  input [31:0] M4;
  input [31:0] M5;
  input [31:0] M6;
  input [31:0] M7;
  input [31:0] M8;
  output [31:0] y;
  wire   n35, n34, n33, n32, n31, n30, n29, n28, n27, n26, n25, n24, n23, n22,
         n21, n20, n19, n18, n17, n16, n15, n14, n13, n12, n11, n10, n9, n8,
         n7, n6, n5, n4, n67, n66, n65, n64, n63, n62, n61, n60, n59, n58, n57,
         n56, n55, n54, n53, n52, n51, n50, n49, n48, n47, n46, n45, n44, n43,
         n42, n41, n40, n39, n38, n37, n36, n99, n98, n97, n96, n95, n94, n93,
         n92, n91, n90, n89, n88, n87, n86, n85, n84, n83, n82, n81, n80, n79,
         n78, n77, n76, n75, n74, n73, n72, n71, n70, n69, n68, n131, n130,
         n129, n128, n127, n126, n125, n124, n123, n122, n121, n120, n119,
         n118, n117, n116, n115, n114, n113, n112, n111, n110, n109, n108,
         n107, n106, n105, n104, n103, n102, n101, n100, n163, n162, n161,
         n160, n159, n158, n157, n156, n155, n154, n153, n152, n151, n150,
         n149, n148, n147, n146, n145, n144, n143, n142, n141, n140, n139,
         n138, n137, n136, n135, n134, n133, n132, n195, n194, n193, n192,
         n191, n190, n189, n188, n187, n186, n185, n184, n183, n182, n181,
         n180, n179, n178, n177, n176, n175, n174, n173, n172, n171, n170,
         n169, n168, n167, n166, n165, n164;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2;
  assign y[0] = 1'b0;
  assign y[1] = 1'b0;
  assign y[2] = 1'b0;

  ADDER_SHIFT_N32 SUM_1 ( .A(M1), .B(M2), .C({n195, n194, n193, n192, n191, 
        n190, n189, n188, n187, n186, n185, n184, n183, n182, n181, n180, n179, 
        n178, n177, n176, n175, n174, n173, n172, n171, n170, n169, n168, n167, 
        n166, n165, n164}) );
  ADDER_SHIFT_N32 SUM_2 ( .A(M3), .B(M4), .C({n163, n162, n161, n160, n159, 
        n158, n157, n156, n155, n154, n153, n152, n151, n150, n149, n148, n147, 
        n146, n145, n144, n143, n142, n141, n140, n139, n138, n137, n136, n135, 
        n134, n133, n132}) );
  ADDER_SHIFT_N32 SUM_3 ( .A(M5), .B(M6), .C({n131, n130, n129, n128, n127, 
        n126, n125, n124, n123, n122, n121, n120, n119, n118, n117, n116, n115, 
        n114, n113, n112, n111, n110, n109, n108, n107, n106, n105, n104, n103, 
        n102, n101, n100}) );
  ADDER_SHIFT_N32 SUM_4 ( .A(M7), .B(M8), .C({n99, n98, n97, n96, n95, n94, 
        n93, n92, n91, n90, n89, n88, n87, n86, n85, n84, n83, n82, n81, n80, 
        n79, n78, n77, n76, n75, n74, n73, n72, n71, n70, n69, n68}) );
  ADDER_SHIFT_N32 SUM_5 ( .A({n195, n194, n193, n192, n191, n190, n189, n188, 
        n187, n186, n185, n184, n183, n182, n181, n180, n179, n178, n177, n176, 
        n175, n174, n173, n172, n171, n170, n169, n168, n167, n166, n165, n164}), .B({n163, n162, n161, n160, n159, n158, n157, n156, n155, n154, n153, n152, 
        n151, n150, n149, n148, n147, n146, n145, n144, n143, n142, n141, n140, 
        n139, n138, n137, n136, n135, n134, n133, n132}), .C({n67, n66, n65, 
        n64, n63, n62, n61, n60, n59, n58, n57, n56, n55, n54, n53, n52, n51, 
        n50, n49, n48, n47, n46, n45, n44, n43, n42, n41, n40, n39, n38, n37, 
        n36}) );
  ADDER_SHIFT_N32 SUM_6 ( .A({n131, n130, n129, n128, n127, n126, n125, n124, 
        n123, n122, n121, n120, n119, n118, n117, n116, n115, n114, n113, n112, 
        n111, n110, n109, n108, n107, n106, n105, n104, n103, n102, n101, n100}), .B({n99, n98, n97, n96, n95, n94, n93, n92, n91, n90, n89, n88, n87, n86, 
        n85, n84, n83, n82, n81, n80, n79, n78, n77, n76, n75, n74, n73, n72, 
        n71, n70, n69, n68}), .C({n35, n34, n33, n32, n31, n30, n29, n28, n27, 
        n26, n25, n24, n23, n22, n21, n20, n19, n18, n17, n16, n15, n14, n13, 
        n12, n11, n10, n9, n8, n7, n6, n5, n4}) );
  ADDER_SHIFT_N32 SUM_7 ( .A({n67, n66, n65, n64, n63, n62, n61, n60, n59, n58, 
        n57, n56, n55, n54, n53, n52, n51, n50, n49, n48, n47, n46, n45, n44, 
        n43, n42, n41, n40, n39, n38, n37, n36}), .B({n35, n34, n33, n32, n31, 
        n30, n29, n28, n27, n26, n25, n24, n23, n22, n21, n20, n19, n18, n17, 
        n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, n4}), .C({y[31], 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, y[30:3]}) );
endmodule


module TRUN_GEN_C_N8_F14 ( A, Y );
  input [31:0] A;
  output [15:0] Y;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n66;

  GTECH_AND2 C26 ( .A(A[28]), .B(A[29]), .Z(n31) );
  GTECH_AND2 C27 ( .A(A[27]), .B(n31), .Z(n30) );
  GTECH_AND2 C28 ( .A(A[26]), .B(n30), .Z(n29) );
  GTECH_AND2 C29 ( .A(A[25]), .B(n29), .Z(n28) );
  GTECH_AND2 C30 ( .A(A[24]), .B(n28), .Z(n27) );
  GTECH_AND2 C31 ( .A(A[23]), .B(n27), .Z(n26) );
  GTECH_AND2 C32 ( .A(A[22]), .B(n26), .Z(n25) );
  GTECH_AND2 C33 ( .A(A[21]), .B(n25), .Z(n24) );
  GTECH_AND2 C34 ( .A(A[20]), .B(n24), .Z(n23) );
  GTECH_AND2 C35 ( .A(A[19]), .B(n23), .Z(n22) );
  GTECH_AND2 C36 ( .A(A[18]), .B(n22), .Z(n21) );
  GTECH_AND2 C37 ( .A(A[17]), .B(n21), .Z(n20) );
  GTECH_AND2 C38 ( .A(A[16]), .B(n20), .Z(n19) );
  GTECH_AND2 C39 ( .A(A[15]), .B(n19), .Z(n18) );
  GTECH_AND2 C40 ( .A(A[14]), .B(n18), .Z(n17) );
  SELECT_OP C41 ( .DATA1({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .DATA2(A[29:14]), 
        .CONTROL1(n66), .CONTROL2(n32), .Z(Y) );
  GTECH_BUF B_0 ( .A(n17), .Z(n66) );
  GTECH_NOT I_0 ( .A(n17), .Z(n32) );
endmodule


module SUB_GEN_N16 ( A, B, Y );
  input [15:0] A;
  input [15:0] B;
  output [15:0] Y;


  SUB_TC_OP sub_79 ( .A(A), .B(B), .Z(Y) );
endmodule


module FIR_SFilter ( clock, reset, x_in, y_out );
  input [15:0] x_in;
  output [15:0] y_out;
  input clock, reset;
  wire   n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, n4, n3, n2, n1,
         n32, n31, n30, n29, n28, n27, n26, n25, n24, n23, n22, n21, n20, n19,
         n18, n17, n48, n47, n46, n45, n44, n43, n42, n41, n40, n39, n38, n37,
         n36, n35, n34, n33, n80, n79, n78, n77, n76, n75, n74, n73, n72, n71,
         n70, n69, n68, n67, n66, n65, n64, n63, n62, n61, n60, n59, n58, n57,
         n56, n55, n54, n53, n52, n51, n50, n49, n112, n111, n110, n109, n108,
         n107, n106, n105, n104, n103, n102, n101, n100, n99, n98, n97, n96,
         n95, n94, n93, n92, n91, n90, n89, n88, n87, n86, n85, n84, n83, n82,
         n81, n128, n127, n126, n125, n124, n123, n122, n121, n120, n119, n118,
         n117, n116, n115, n114, n113, n144, n143, n142, n141, n140, n139,
         n138, n137, n136, n135, n134, n133, n132, n131, n130, n129;

  REG_N16 R1 ( .clock(clock), .CL(reset), .A(y_out), .S({n144, n143, n142, 
        n141, n140, n139, n138, n137, n136, n135, n134, n133, n132, n131, n130, 
        n129}) );
  REG_N16 R2 ( .clock(clock), .CL(reset), .A({n144, n143, n142, n141, n140, 
        n139, n138, n137, n136, n135, n134, n133, n132, n131, n130, n129}), 
        .S({n128, n127, n126, n125, n124, n123, n122, n121, n120, n119, n118, 
        n117, n116, n115, n114, n113}) );
  MULT_GEN_N16 Mult1 ( .A({n144, n143, n142, n141, n140, n139, n138, n137, 
        n136, n135, n134, n133, n132, n131, n130, n129}), .B({1'b0, 1'b0, 1'b1, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0}), .Y({n112, n111, n110, n109, n108, n107, n106, n105, n104, n103, 
        n102, n101, n100, n99, n98, n97, n96, n95, n94, n93, n92, n91, n90, 
        n89, n88, n87, n86, n85, n84, n83, n82, n81}) );
  MULT_GEN_N16 Mult2 ( .A({n128, n127, n126, n125, n124, n123, n122, n121, 
        n120, n119, n118, n117, n116, n115, n114, n113}), .B({1'b0, 1'b0, 1'b0, 
        1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 
        1'b1}), .Y({n80, n79, n78, n77, n76, n75, n74, n73, n72, n71, n70, n69, 
        n68, n67, n66, n65, n64, n63, n62, n61, n60, n59, n58, n57, n56, n55, 
        n54, n53, n52, n51, n50, n49}) );
  TRUN_GEN_C_N8_F14 T_1 ( .A({n112, n111, n110, n109, n108, n107, n106, n105, 
        n104, n103, n102, n101, n100, n99, n98, n97, n96, n95, n94, n93, n92, 
        n91, n90, n89, n88, n87, n86, n85, n84, n83, n82, n81}), .Y({n48, n47, 
        n46, n45, n44, n43, n42, n41, n40, n39, n38, n37, n36, n35, n34, n33})
         );
  TRUN_GEN_C_N8_F14 T_2 ( .A({n80, n79, n78, n77, n76, n75, n74, n73, n72, n71, 
        n70, n69, n68, n67, n66, n65, n64, n63, n62, n61, n60, n59, n58, n57, 
        n56, n55, n54, n53, n52, n51, n50, n49}), .Y({n32, n31, n30, n29, n28, 
        n27, n26, n25, n24, n23, n22, n21, n20, n19, n18, n17}) );
  SUB_GEN_N16 Sub1 ( .A(x_in), .B({n48, n47, n46, n45, n44, n43, n42, n41, n40, 
        n39, n38, n37, n36, n35, n34, n33}), .Y({n16, n15, n14, n13, n12, n11, 
        n10, n9, n8, n7, n6, n5, n4, n3, n2, n1}) );
  SUB_GEN_N16 Sub2 ( .A({n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, 
        n4, n3, n2, n1}), .B({n32, n31, n30, n29, n28, n27, n26, n25, n24, n23, 
        n22, n21, n20, n19, n18, n17}), .Y(y_out) );
endmodule


module SUM_GEN_N16 ( A, B, Y );
  input [15:0] A;
  input [15:0] B;
  output [15:0] Y;


  ADD_TC_OP \*cell*563  ( .A(A), .B(B), .Z(Y) );
endmodule


module MULT_GEN2_N16 ( A, B, Y );
  input [15:0] A;
  input [15:0] B;
  output [31:0] Y;


  MULT_TC_OP mult_122 ( .A(A), .B(B), .Z(Y) );
endmodule


module REG_N32 ( clock, CL, A, S );
  input [31:0] A;
  output [31:0] S;
  input clock, CL;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n102, n103;

  \**SEQGEN**  \S_reg[31]  ( .clear(1'b0), .preset(1'b0), .next_state(n1), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[31]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[30]  ( .clear(1'b0), .preset(1'b0), .next_state(n2), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[30]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[29]  ( .clear(1'b0), .preset(1'b0), .next_state(n3), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[29]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[28]  ( .clear(1'b0), .preset(1'b0), .next_state(n4), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[28]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[27]  ( .clear(1'b0), .preset(1'b0), .next_state(n5), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[27]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[26]  ( .clear(1'b0), .preset(1'b0), .next_state(n6), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[26]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[25]  ( .clear(1'b0), .preset(1'b0), .next_state(n7), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[25]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[24]  ( .clear(1'b0), .preset(1'b0), .next_state(n8), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[24]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[23]  ( .clear(1'b0), .preset(1'b0), .next_state(n9), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[23]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[22]  ( .clear(1'b0), .preset(1'b0), .next_state(n10), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[22]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[21]  ( .clear(1'b0), .preset(1'b0), .next_state(n11), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[21]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[20]  ( .clear(1'b0), .preset(1'b0), .next_state(n12), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[20]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[19]  ( .clear(1'b0), .preset(1'b0), .next_state(n13), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[19]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[18]  ( .clear(1'b0), .preset(1'b0), .next_state(n14), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[18]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[17]  ( .clear(1'b0), .preset(1'b0), .next_state(n15), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[17]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[16]  ( .clear(1'b0), .preset(1'b0), .next_state(n16), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[16]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[15]  ( .clear(1'b0), .preset(1'b0), .next_state(n17), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[15]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[14]  ( .clear(1'b0), .preset(1'b0), .next_state(n18), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[14]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[13]  ( .clear(1'b0), .preset(1'b0), .next_state(n19), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[13]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[12]  ( .clear(1'b0), .preset(1'b0), .next_state(n20), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[12]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[11]  ( .clear(1'b0), .preset(1'b0), .next_state(n21), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[11]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[10]  ( .clear(1'b0), .preset(1'b0), .next_state(n22), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[10]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[9]  ( .clear(1'b0), .preset(1'b0), .next_state(n23), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[9]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[8]  ( .clear(1'b0), .preset(1'b0), .next_state(n24), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[8]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(n25), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[7]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(n26), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[6]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(n27), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[5]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(n28), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[4]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(n29), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[3]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(n30), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[2]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(n31), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[1]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \S_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(n32), 
        .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(S[0]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  SELECT_OP C42 ( .DATA1({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .DATA2(A), .CONTROL1(n103), .CONTROL2(n102), .Z({n1, n2, n3, n4, n5, 
        n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, 
        n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32}) );
  GTECH_BUF B_0 ( .A(CL), .Z(n103) );
  GTECH_BUF B_1 ( .A(n33), .Z(n102) );
  GTECH_NOT I_0 ( .A(CL), .Z(n33) );
endmodule


module LMS_Direct_10taps ( clock, reset, x, d, mi, e, y );
  input [15:0] x;
  input [15:0] d;
  input [15:0] mi;
  output [15:0] e;
  output [15:0] y;
  input clock, reset;
  wire   n320, n319, n318, n317, n316, n315, n314, n313, n312, n311, n310,
         n309, n308, n307, n306, n305, n304, n303, n302, n301, n300, n299,
         n298, n297, n296, n295, n294, n293, n292, n291, n290, n289, n288,
         n287, n286, n285, n284, n283, n282, n281, n280, n279, n278, n277,
         n276, n275, n274, n273, n272, n271, n270, n269, n268, n267, n266,
         n265, n264, n263, n262, n261, n260, n259, n258, n257, n256, n255,
         n254, n253, n252, n251, n250, n249, n248, n247, n246, n245, n244,
         n243, n242, n241, n240, n239, n238, n237, n236, n235, n234, n233,
         n232, n231, n230, n229, n228, n227, n226, n225, n224, n223, n222,
         n221, n220, n219, n218, n217, n216, n215, n214, n213, n212, n211,
         n210, n209, n208, n207, n206, n205, n204, n203, n202, n201, n200,
         n199, n198, n197, n196, n195, n194, n193, n192, n191, n190, n189,
         n188, n187, n186, n185, n184, n183, n182, n181, n180, n179, n178,
         n177, n176, n175, n174, n173, n172, n171, n170, n169, n168, n167,
         n166, n165, n164, n163, n162, n161, n160, n159, n158, n157, n156,
         n155, n154, n153, n152, n151, n150, n149, n148, n147, n146, n145,
         n144, n143, n142, n141, n140, n139, n138, n137, n136, n135, n134,
         n133, n132, n131, n130, n129, n128, n127, n126, n125, n124, n123,
         n122, n121, n120, n119, n118, n117, n116, n115, n114, n113, n112,
         n111, n110, n109, n108, n107, n106, n105, n104, n103, n102, n101,
         n100, n99, n98, n97, n96, n95, n94, n93, n92, n91, n90, n89, n88, n87,
         n86, n85, n84, n83, n82, n81, n80, n79, n78, n77, n76, n75, n74, n73,
         n72, n71, n70, n69, n68, n67, n66, n65, n64, n63, n62, n61, n60, n59,
         n58, n57, n56, n55, n54, n53, n52, n51, n50, n49, n48, n47, n46, n45,
         n44, n43, n42, n41, n40, n39, n38, n37, n36, n35, n34, n33, n32, n31,
         n30, n29, n28, n27, n26, n25, n24, n23, n22, n21, n20, n19, n18, n17,
         n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, n4, n3, n2, n1,
         n640, n639, n638, n637, n636, n635, n634, n633, n632, n631, n630,
         n629, n628, n627, n626, n625, n624, n623, n622, n621, n620, n619,
         n618, n617, n616, n615, n614, n613, n612, n611, n610, n609, n608,
         n607, n606, n605, n604, n603, n602, n601, n600, n599, n598, n597,
         n596, n595, n594, n593, n592, n591, n590, n589, n588, n587, n586,
         n585, n584, n583, n582, n581, n580, n579, n578, n577, n576, n575,
         n574, n573, n572, n571, n570, n569, n568, n567, n566, n565, n564,
         n563, n562, n561, n560, n559, n558, n557, n556, n555, n554, n553,
         n552, n551, n550, n549, n548, n547, n546, n545, n544, n543, n542,
         n541, n540, n539, n538, n537, n536, n535, n534, n533, n532, n531,
         n530, n529, n528, n527, n526, n525, n524, n523, n522, n521, n520,
         n519, n518, n517, n516, n515, n514, n513, n512, n511, n510, n509,
         n508, n507, n506, n505, n504, n503, n502, n501, n500, n499, n498,
         n497, n496, n495, n494, n493, n492, n491, n490, n489, n488, n487,
         n486, n485, n484, n483, n482, n481, n480, n479, n478, n477, n476,
         n475, n474, n473, n472, n471, n470, n469, n468, n467, n466, n465,
         n464, n463, n462, n461, n460, n459, n458, n457, n456, n455, n454,
         n453, n452, n451, n450, n449, n448, n447, n446, n445, n444, n443,
         n442, n441, n440, n439, n438, n437, n436, n435, n434, n433, n432,
         n431, n430, n429, n428, n427, n426, n425, n424, n423, n422, n421,
         n420, n419, n418, n417, n416, n415, n414, n413, n412, n411, n410,
         n409, n408, n407, n406, n405, n404, n403, n402, n401, n400, n399,
         n398, n397, n396, n395, n394, n393, n392, n391, n390, n389, n388,
         n387, n386, n385, n384, n383, n382, n381, n380, n379, n378, n377,
         n376, n375, n374, n373, n372, n371, n370, n369, n368, n367, n366,
         n365, n364, n363, n362, n361, n360, n359, n358, n357, n356, n355,
         n354, n353, n352, n351, n350, n349, n348, n347, n346, n345, n344,
         n343, n342, n341, n340, n339, n338, n337, n336, n335, n334, n333,
         n332, n331, n330, n329, n328, n327, n326, n325, n324, n323, n322,
         n321, n960, n959, n958, n957, n956, n955, n954, n953, n952, n951,
         n950, n949, n948, n947, n946, n945, n944, n943, n942, n941, n940,
         n939, n938, n937, n936, n935, n934, n933, n932, n931, n930, n929,
         n928, n927, n926, n925, n924, n923, n922, n921, n920, n919, n918,
         n917, n916, n915, n914, n913, n912, n911, n910, n909, n908, n907,
         n906, n905, n904, n903, n902, n901, n900, n899, n898, n897, n896,
         n895, n894, n893, n892, n891, n890, n889, n888, n887, n886, n885,
         n884, n883, n882, n881, n880, n879, n878, n877, n876, n875, n874,
         n873, n872, n871, n870, n869, n868, n867, n866, n865, n864, n863,
         n862, n861, n860, n859, n858, n857, n856, n855, n854, n853, n852,
         n851, n850, n849, n848, n847, n846, n845, n844, n843, n842, n841,
         n840, n839, n838, n837, n836, n835, n834, n833, n832, n831, n830,
         n829, n828, n827, n826, n825, n824, n823, n822, n821, n820, n819,
         n818, n817, n816, n815, n814, n813, n812, n811, n810, n809, n808,
         n807, n806, n805, n804, n803, n802, n801, n800, n799, n798, n797,
         n796, n795, n794, n793, n792, n791, n790, n789, n788, n787, n786,
         n785, n784, n783, n782, n781, n780, n779, n778, n777, n776, n775,
         n774, n773, n772, n771, n770, n769, n768, n767, n766, n765, n764,
         n763, n762, n761, n760, n759, n758, n757, n756, n755, n754, n753,
         n752, n751, n750, n749, n748, n747, n746, n745, n744, n743, n742,
         n741, n740, n739, n738, n737, n736, n735, n734, n733, n732, n731,
         n730, n729, n728, n727, n726, n725, n724, n723, n722, n721, n720,
         n719, n718, n717, n716, n715, n714, n713, n712, n711, n710, n709,
         n708, n707, n706, n705, n704, n703, n702, n701, n700, n699, n698,
         n697, n696, n695, n694, n693, n692, n691, n690, n689, n688, n687,
         n686, n685, n684, n683, n682, n681, n680, n679, n678, n677, n676,
         n675, n674, n673, n672, n671, n670, n669, n668, n667, n666, n665,
         n664, n663, n662, n661, n660, n659, n658, n657, n656, n655, n654,
         n653, n652, n651, n650, n649, n648, n647, n646, n645, n644, n643,
         n642, n641, n976, n975, n974, n973, n972, n971, n970, n969, n968,
         n967, n966, n965, n964, n963, n962, n961, n1008, n1007, n1006, n1005,
         n1004, n1003, n1002, n1001, n1000, n999, n998, n997, n996, n995, n994,
         n993, n992, n991, n990, n989, n988, n987, n986, n985, n984, n983,
         n982, n981, n980, n979, n978, n977, n1024, n1023, n1022, n1021, n1020,
         n1019, n1018, n1017, n1016, n1015, n1014, n1013, n1012, n1011, n1010,
         n1009, n1040, n1039, n1038, n1037, n1036, n1035, n1034, n1033, n1032,
         n1031, n1030, n1029, n1028, n1027, n1026, n1025, n1072, n1071, n1070,
         n1069, n1068, n1067, n1066, n1065, n1064, n1063, n1062, n1061, n1060,
         n1059, n1058, n1057, n1056, n1055, n1054, n1053, n1052, n1051, n1050,
         n1049, n1048, n1047, n1046, n1045, n1044, n1043, n1042, n1041, n1104,
         n1103, n1102, n1101, n1100, n1099, n1098, n1097, n1096, n1095, n1094,
         n1093, n1092, n1091, n1090, n1089, n1088, n1087, n1086, n1085, n1084,
         n1083, n1082, n1081, n1080, n1079, n1078, n1077, n1076, n1075, n1074,
         n1073, n1136, n1135, n1134, n1133, n1132, n1131, n1130, n1129, n1128,
         n1127, n1126, n1125, n1124, n1123, n1122, n1121, n1120, n1119, n1118,
         n1117, n1116, n1115, n1114, n1113, n1112, n1111, n1110, n1109, n1108,
         n1107, n1106, n1105, n1168, n1167, n1166, n1165, n1164, n1163, n1162,
         n1161, n1160, n1159, n1158, n1157, n1156, n1155, n1154, n1153, n1152,
         n1151, n1150, n1149, n1148, n1147, n1146, n1145, n1144, n1143, n1142,
         n1141, n1140, n1139, n1138, n1137, n1488, n1487, n1486, n1485, n1484,
         n1483, n1482, n1481, n1480, n1479, n1478, n1477, n1476, n1475, n1474,
         n1473, n1472, n1471, n1470, n1469, n1468, n1467, n1466, n1465, n1464,
         n1463, n1462, n1461, n1460, n1459, n1458, n1457, n1456, n1455, n1454,
         n1453, n1452, n1451, n1450, n1449, n1448, n1447, n1446, n1445, n1444,
         n1443, n1442, n1441, n1440, n1439, n1438, n1437, n1436, n1435, n1434,
         n1433, n1432, n1431, n1430, n1429, n1428, n1427, n1426, n1425, n1424,
         n1423, n1422, n1421, n1420, n1419, n1418, n1417, n1416, n1415, n1414,
         n1413, n1412, n1411, n1410, n1409, n1408, n1407, n1406, n1405, n1404,
         n1403, n1402, n1401, n1400, n1399, n1398, n1397, n1396, n1395, n1394,
         n1393, n1392, n1391, n1390, n1389, n1388, n1387, n1386, n1385, n1384,
         n1383, n1382, n1381, n1380, n1379, n1378, n1377, n1376, n1375, n1374,
         n1373, n1372, n1371, n1370, n1369, n1368, n1367, n1366, n1365, n1364,
         n1363, n1362, n1361, n1360, n1359, n1358, n1357, n1356, n1355, n1354,
         n1353, n1352, n1351, n1350, n1349, n1348, n1347, n1346, n1345, n1344,
         n1343, n1342, n1341, n1340, n1339, n1338, n1337, n1336, n1335, n1334,
         n1333, n1332, n1331, n1330, n1329, n1328, n1327, n1326, n1325, n1324,
         n1323, n1322, n1321, n1320, n1319, n1318, n1317, n1316, n1315, n1314,
         n1313, n1312, n1311, n1310, n1309, n1308, n1307, n1306, n1305, n1304,
         n1303, n1302, n1301, n1300, n1299, n1298, n1297, n1296, n1295, n1294,
         n1293, n1292, n1291, n1290, n1289, n1288, n1287, n1286, n1285, n1284,
         n1283, n1282, n1281, n1280, n1279, n1278, n1277, n1276, n1275, n1274,
         n1273, n1272, n1271, n1270, n1269, n1268, n1267, n1266, n1265, n1264,
         n1263, n1262, n1261, n1260, n1259, n1258, n1257, n1256, n1255, n1254,
         n1253, n1252, n1251, n1250, n1249, n1248, n1247, n1246, n1245, n1244,
         n1243, n1242, n1241, n1240, n1239, n1238, n1237, n1236, n1235, n1234,
         n1233, n1232, n1231, n1230, n1229, n1228, n1227, n1226, n1225, n1224,
         n1223, n1222, n1221, n1220, n1219, n1218, n1217, n1216, n1215, n1214,
         n1213, n1212, n1211, n1210, n1209, n1208, n1207, n1206, n1205, n1204,
         n1203, n1202, n1201, n1200, n1199, n1198, n1197, n1196, n1195, n1194,
         n1193, n1192, n1191, n1190, n1189, n1188, n1187, n1186, n1185, n1184,
         n1183, n1182, n1181, n1180, n1179, n1178, n1177, n1176, n1175, n1174,
         n1173, n1172, n1171, n1170, n1169, n1648, n1647, n1646, n1645, n1644,
         n1643, n1642, n1641, n1640, n1639, n1638, n1637, n1636, n1635, n1634,
         n1633, n1632, n1631, n1630, n1629, n1628, n1627, n1626, n1625, n1624,
         n1623, n1622, n1621, n1620, n1619, n1618, n1617, n1616, n1615, n1614,
         n1613, n1612, n1611, n1610, n1609, n1608, n1607, n1606, n1605, n1604,
         n1603, n1602, n1601, n1600, n1599, n1598, n1597, n1596, n1595, n1594,
         n1593, n1592, n1591, n1590, n1589, n1588, n1587, n1586, n1585, n1584,
         n1583, n1582, n1581, n1580, n1579, n1578, n1577, n1576, n1575, n1574,
         n1573, n1572, n1571, n1570, n1569, n1568, n1567, n1566, n1565, n1564,
         n1563, n1562, n1561, n1560, n1559, n1558, n1557, n1556, n1555, n1554,
         n1553, n1552, n1551, n1550, n1549, n1548, n1547, n1546, n1545, n1544,
         n1543, n1542, n1541, n1540, n1539, n1538, n1537, n1536, n1535, n1534,
         n1533, n1532, n1531, n1530, n1529, n1528, n1527, n1526, n1525, n1524,
         n1523, n1522, n1521, n1520, n1519, n1518, n1517, n1516, n1515, n1514,
         n1513, n1512, n1511, n1510, n1509, n1508, n1507, n1506, n1505, n1504,
         n1503, n1502, n1501, n1500, n1499, n1498, n1497, n1496, n1495, n1494,
         n1493, n1492, n1491, n1490, n1489, n1649, n1650, n1651, n1652, n1653,
         n1654, n1655, n1656, n1657, n1658, n1659, n1660, n1661, n1662, n1663,
         n1664, n1665, n1666, n1667, n1668, n1669, n1670, n1671, n1672, n1673,
         n1674, n1675, n1676, n1677, n1678, n1679, n1680, n1681, n1682, n1683,
         n1684, n1685, n1686, n1687, n1688, n1689, n1690, n1691, n1692, n1693,
         n1694, n1695, n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703,
         n1704, n1705, n1706, n1707, n1708, n1709, n1710, n1711, n1712, n1713,
         n1714, n1715, n1716, n1717, n1718, n1719, n1720, n1721, n1722, n1723,
         n1724, n1725, n1726, n1727, n1728, n1729, n1730, n1731, n1732, n1733,
         n1734, n1735, n1736, n1737, n1738, n1739, n1740, n1741, n1742, n1743,
         n1744, n1745, n1746, n1747, n1748, n1749, n1750, n1751, n1752, n1753,
         n1754, n1755, n1756, n1757, n1758, n1759, n1760, n1761, n1762, n1763,
         n1764, n1765, n1766, n1767, n1768, n1769, n1770, n1771, n1772, n1773,
         n1774, n1775, n1776, n1777, n1778, n1779, n1780, n1781, n1782, n1783,
         n1784, n1785, n1786, n1787, n1788, n1789, n1790, n1791, n1792;

  REG_N16 \gen_reg[0].R  ( .clock(clock), .CL(reset), .A(x), .S({n1792, n1791, 
        n1790, n1789, n1788, n1787, n1786, n1785, n1784, n1783, n1782, n1781, 
        n1780, n1779, n1778, n1777}) );
  REG_N16 \gen_reg[1].R  ( .clock(clock), .CL(reset), .A({n1792, n1791, n1790, 
        n1789, n1788, n1787, n1786, n1785, n1784, n1783, n1782, n1781, n1780, 
        n1779, n1778, n1777}), .S({n1776, n1775, n1774, n1773, n1772, n1771, 
        n1770, n1769, n1768, n1767, n1766, n1765, n1764, n1763, n1762, n1761})
         );
  REG_N16 \gen_reg[2].R  ( .clock(clock), .CL(reset), .A({n1776, n1775, n1774, 
        n1773, n1772, n1771, n1770, n1769, n1768, n1767, n1766, n1765, n1764, 
        n1763, n1762, n1761}), .S({n1760, n1759, n1758, n1757, n1756, n1755, 
        n1754, n1753, n1752, n1751, n1750, n1749, n1748, n1747, n1746, n1745})
         );
  REG_N16 \gen_reg[3].R  ( .clock(clock), .CL(reset), .A({n1760, n1759, n1758, 
        n1757, n1756, n1755, n1754, n1753, n1752, n1751, n1750, n1749, n1748, 
        n1747, n1746, n1745}), .S({n1744, n1743, n1742, n1741, n1740, n1739, 
        n1738, n1737, n1736, n1735, n1734, n1733, n1732, n1731, n1730, n1729})
         );
  REG_N16 \gen_reg[4].R  ( .clock(clock), .CL(reset), .A({n1744, n1743, n1742, 
        n1741, n1740, n1739, n1738, n1737, n1736, n1735, n1734, n1733, n1732, 
        n1731, n1730, n1729}), .S({n1728, n1727, n1726, n1725, n1724, n1723, 
        n1722, n1721, n1720, n1719, n1718, n1717, n1716, n1715, n1714, n1713})
         );
  REG_N16 \gen_reg[5].R  ( .clock(clock), .CL(reset), .A({n1728, n1727, n1726, 
        n1725, n1724, n1723, n1722, n1721, n1720, n1719, n1718, n1717, n1716, 
        n1715, n1714, n1713}), .S({n1712, n1711, n1710, n1709, n1708, n1707, 
        n1706, n1705, n1704, n1703, n1702, n1701, n1700, n1699, n1698, n1697})
         );
  REG_N16 \gen_reg[6].R  ( .clock(clock), .CL(reset), .A({n1712, n1711, n1710, 
        n1709, n1708, n1707, n1706, n1705, n1704, n1703, n1702, n1701, n1700, 
        n1699, n1698, n1697}), .S({n1696, n1695, n1694, n1693, n1692, n1691, 
        n1690, n1689, n1688, n1687, n1686, n1685, n1684, n1683, n1682, n1681})
         );
  REG_N16 \gen_reg[7].R  ( .clock(clock), .CL(reset), .A({n1696, n1695, n1694, 
        n1693, n1692, n1691, n1690, n1689, n1688, n1687, n1686, n1685, n1684, 
        n1683, n1682, n1681}), .S({n1680, n1679, n1678, n1677, n1676, n1675, 
        n1674, n1673, n1672, n1671, n1670, n1669, n1668, n1667, n1666, n1665})
         );
  REG_N16 \gen_reg[8].R  ( .clock(clock), .CL(reset), .A({n1680, n1679, n1678, 
        n1677, n1676, n1675, n1674, n1673, n1672, n1671, n1670, n1669, n1668, 
        n1667, n1666, n1665}), .S({n1664, n1663, n1662, n1661, n1660, n1659, 
        n1658, n1657, n1656, n1655, n1654, n1653, n1652, n1651, n1650, n1649})
         );
  MULT_GEN_N16 \gen_mul[0].Mult  ( .A({n1648, n1647, n1646, n1645, n1644, 
        n1643, n1642, n1641, n1640, n1639, n1638, n1637, n1636, n1635, n1634, 
        n1633}), .B(x), .Y({n1488, n1487, n1486, n1485, n1484, n1483, n1482, 
        n1481, n1480, n1479, n1478, n1477, n1476, n1475, n1474, n1473, n1472, 
        n1471, n1470, n1469, n1468, n1467, n1466, n1465, n1464, n1463, n1462, 
        n1461, n1460, n1459, n1458, n1457}) );
  MULT_GEN_N16 \gen_mul[1].Mult  ( .A({n1632, n1631, n1630, n1629, n1628, 
        n1627, n1626, n1625, n1624, n1623, n1622, n1621, n1620, n1619, n1618, 
        n1617}), .B({n1792, n1791, n1790, n1789, n1788, n1787, n1786, n1785, 
        n1784, n1783, n1782, n1781, n1780, n1779, n1778, n1777}), .Y({n1456, 
        n1455, n1454, n1453, n1452, n1451, n1450, n1449, n1448, n1447, n1446, 
        n1445, n1444, n1443, n1442, n1441, n1440, n1439, n1438, n1437, n1436, 
        n1435, n1434, n1433, n1432, n1431, n1430, n1429, n1428, n1427, n1426, 
        n1425}) );
  MULT_GEN_N16 \gen_mul[2].Mult  ( .A({n1616, n1615, n1614, n1613, n1612, 
        n1611, n1610, n1609, n1608, n1607, n1606, n1605, n1604, n1603, n1602, 
        n1601}), .B({n1776, n1775, n1774, n1773, n1772, n1771, n1770, n1769, 
        n1768, n1767, n1766, n1765, n1764, n1763, n1762, n1761}), .Y({n1424, 
        n1423, n1422, n1421, n1420, n1419, n1418, n1417, n1416, n1415, n1414, 
        n1413, n1412, n1411, n1410, n1409, n1408, n1407, n1406, n1405, n1404, 
        n1403, n1402, n1401, n1400, n1399, n1398, n1397, n1396, n1395, n1394, 
        n1393}) );
  MULT_GEN_N16 \gen_mul[3].Mult  ( .A({n1600, n1599, n1598, n1597, n1596, 
        n1595, n1594, n1593, n1592, n1591, n1590, n1589, n1588, n1587, n1586, 
        n1585}), .B({n1760, n1759, n1758, n1757, n1756, n1755, n1754, n1753, 
        n1752, n1751, n1750, n1749, n1748, n1747, n1746, n1745}), .Y({n1392, 
        n1391, n1390, n1389, n1388, n1387, n1386, n1385, n1384, n1383, n1382, 
        n1381, n1380, n1379, n1378, n1377, n1376, n1375, n1374, n1373, n1372, 
        n1371, n1370, n1369, n1368, n1367, n1366, n1365, n1364, n1363, n1362, 
        n1361}) );
  MULT_GEN_N16 \gen_mul[4].Mult  ( .A({n1584, n1583, n1582, n1581, n1580, 
        n1579, n1578, n1577, n1576, n1575, n1574, n1573, n1572, n1571, n1570, 
        n1569}), .B({n1744, n1743, n1742, n1741, n1740, n1739, n1738, n1737, 
        n1736, n1735, n1734, n1733, n1732, n1731, n1730, n1729}), .Y({n1360, 
        n1359, n1358, n1357, n1356, n1355, n1354, n1353, n1352, n1351, n1350, 
        n1349, n1348, n1347, n1346, n1345, n1344, n1343, n1342, n1341, n1340, 
        n1339, n1338, n1337, n1336, n1335, n1334, n1333, n1332, n1331, n1330, 
        n1329}) );
  MULT_GEN_N16 \gen_mul[5].Mult  ( .A({n1568, n1567, n1566, n1565, n1564, 
        n1563, n1562, n1561, n1560, n1559, n1558, n1557, n1556, n1555, n1554, 
        n1553}), .B({n1728, n1727, n1726, n1725, n1724, n1723, n1722, n1721, 
        n1720, n1719, n1718, n1717, n1716, n1715, n1714, n1713}), .Y({n1328, 
        n1327, n1326, n1325, n1324, n1323, n1322, n1321, n1320, n1319, n1318, 
        n1317, n1316, n1315, n1314, n1313, n1312, n1311, n1310, n1309, n1308, 
        n1307, n1306, n1305, n1304, n1303, n1302, n1301, n1300, n1299, n1298, 
        n1297}) );
  MULT_GEN_N16 \gen_mul[6].Mult  ( .A({n1552, n1551, n1550, n1549, n1548, 
        n1547, n1546, n1545, n1544, n1543, n1542, n1541, n1540, n1539, n1538, 
        n1537}), .B({n1712, n1711, n1710, n1709, n1708, n1707, n1706, n1705, 
        n1704, n1703, n1702, n1701, n1700, n1699, n1698, n1697}), .Y({n1296, 
        n1295, n1294, n1293, n1292, n1291, n1290, n1289, n1288, n1287, n1286, 
        n1285, n1284, n1283, n1282, n1281, n1280, n1279, n1278, n1277, n1276, 
        n1275, n1274, n1273, n1272, n1271, n1270, n1269, n1268, n1267, n1266, 
        n1265}) );
  MULT_GEN_N16 \gen_mul[7].Mult  ( .A({n1536, n1535, n1534, n1533, n1532, 
        n1531, n1530, n1529, n1528, n1527, n1526, n1525, n1524, n1523, n1522, 
        n1521}), .B({n1696, n1695, n1694, n1693, n1692, n1691, n1690, n1689, 
        n1688, n1687, n1686, n1685, n1684, n1683, n1682, n1681}), .Y({n1264, 
        n1263, n1262, n1261, n1260, n1259, n1258, n1257, n1256, n1255, n1254, 
        n1253, n1252, n1251, n1250, n1249, n1248, n1247, n1246, n1245, n1244, 
        n1243, n1242, n1241, n1240, n1239, n1238, n1237, n1236, n1235, n1234, 
        n1233}) );
  MULT_GEN_N16 \gen_mul[8].Mult  ( .A({n1520, n1519, n1518, n1517, n1516, 
        n1515, n1514, n1513, n1512, n1511, n1510, n1509, n1508, n1507, n1506, 
        n1505}), .B({n1680, n1679, n1678, n1677, n1676, n1675, n1674, n1673, 
        n1672, n1671, n1670, n1669, n1668, n1667, n1666, n1665}), .Y({n1232, 
        n1231, n1230, n1229, n1228, n1227, n1226, n1225, n1224, n1223, n1222, 
        n1221, n1220, n1219, n1218, n1217, n1216, n1215, n1214, n1213, n1212, 
        n1211, n1210, n1209, n1208, n1207, n1206, n1205, n1204, n1203, n1202, 
        n1201}) );
  MULT_GEN_N16 \gen_mul[9].Mult  ( .A({n1504, n1503, n1502, n1501, n1500, 
        n1499, n1498, n1497, n1496, n1495, n1494, n1493, n1492, n1491, n1490, 
        n1489}), .B({n1664, n1663, n1662, n1661, n1660, n1659, n1658, n1657, 
        n1656, n1655, n1654, n1653, n1652, n1651, n1650, n1649}), .Y({n1200, 
        n1199, n1198, n1197, n1196, n1195, n1194, n1193, n1192, n1191, n1190, 
        n1189, n1188, n1187, n1186, n1185, n1184, n1183, n1182, n1181, n1180, 
        n1179, n1178, n1177, n1176, n1175, n1174, n1173, n1172, n1171, n1170, 
        n1169}) );
  SUM_GEN_N32 SUM_tree2 ( .A({n1488, n1487, n1486, n1485, n1484, n1483, n1482, 
        n1481, n1480, n1479, n1478, n1477, n1476, n1475, n1474, n1473, n1472, 
        n1471, n1470, n1469, n1468, n1467, n1466, n1465, n1464, n1463, n1462, 
        n1461, n1460, n1459, n1458, n1457}), .B({n1456, n1455, n1454, n1453, 
        n1452, n1451, n1450, n1449, n1448, n1447, n1446, n1445, n1444, n1443, 
        n1442, n1441, n1440, n1439, n1438, n1437, n1436, n1435, n1434, n1433, 
        n1432, n1431, n1430, n1429, n1428, n1427, n1426, n1425}), .Y({n1168, 
        n1167, n1166, n1165, n1164, n1163, n1162, n1161, n1160, n1159, n1158, 
        n1157, n1156, n1155, n1154, n1153, n1152, n1151, n1150, n1149, n1148, 
        n1147, n1146, n1145, n1144, n1143, n1142, n1141, n1140, n1139, n1138, 
        n1137}) );
  tree_8_N32 AT2 ( .M1({n1424, n1423, n1422, n1421, n1420, n1419, n1418, n1417, 
        n1416, n1415, n1414, n1413, n1412, n1411, n1410, n1409, n1408, n1407, 
        n1406, n1405, n1404, n1403, n1402, n1401, n1400, n1399, n1398, n1397, 
        n1396, n1395, n1394, n1393}), .M2({n1392, n1391, n1390, n1389, n1388, 
        n1387, n1386, n1385, n1384, n1383, n1382, n1381, n1380, n1379, n1378, 
        n1377, n1376, n1375, n1374, n1373, n1372, n1371, n1370, n1369, n1368, 
        n1367, n1366, n1365, n1364, n1363, n1362, n1361}), .M3({n1360, n1359, 
        n1358, n1357, n1356, n1355, n1354, n1353, n1352, n1351, n1350, n1349, 
        n1348, n1347, n1346, n1345, n1344, n1343, n1342, n1341, n1340, n1339, 
        n1338, n1337, n1336, n1335, n1334, n1333, n1332, n1331, n1330, n1329}), 
        .M4({n1328, n1327, n1326, n1325, n1324, n1323, n1322, n1321, n1320, 
        n1319, n1318, n1317, n1316, n1315, n1314, n1313, n1312, n1311, n1310, 
        n1309, n1308, n1307, n1306, n1305, n1304, n1303, n1302, n1301, n1300, 
        n1299, n1298, n1297}), .M5({n1296, n1295, n1294, n1293, n1292, n1291, 
        n1290, n1289, n1288, n1287, n1286, n1285, n1284, n1283, n1282, n1281, 
        n1280, n1279, n1278, n1277, n1276, n1275, n1274, n1273, n1272, n1271, 
        n1270, n1269, n1268, n1267, n1266, n1265}), .M6({n1264, n1263, n1262, 
        n1261, n1260, n1259, n1258, n1257, n1256, n1255, n1254, n1253, n1252, 
        n1251, n1250, n1249, n1248, n1247, n1246, n1245, n1244, n1243, n1242, 
        n1241, n1240, n1239, n1238, n1237, n1236, n1235, n1234, n1233}), .M7({
        n1232, n1231, n1230, n1229, n1228, n1227, n1226, n1225, n1224, n1223, 
        n1222, n1221, n1220, n1219, n1218, n1217, n1216, n1215, n1214, n1213, 
        n1212, n1211, n1210, n1209, n1208, n1207, n1206, n1205, n1204, n1203, 
        n1202, n1201}), .M8({n1200, n1199, n1198, n1197, n1196, n1195, n1194, 
        n1193, n1192, n1191, n1190, n1189, n1188, n1187, n1186, n1185, n1184, 
        n1183, n1182, n1181, n1180, n1179, n1178, n1177, n1176, n1175, n1174, 
        n1173, n1172, n1171, n1170, n1169}), .y({n1136, n1135, n1134, n1133, 
        n1132, n1131, n1130, n1129, n1128, n1127, n1126, n1125, n1124, n1123, 
        n1122, n1121, n1120, n1119, n1118, n1117, n1116, n1115, n1114, n1113, 
        n1112, n1111, n1110, n1109, n1108, n1107, n1106, n1105}) );
  SUM_GEN_N32 SUM_10 ( .A({n1168, n1167, n1166, n1165, n1164, n1163, n1162, 
        n1161, n1160, n1159, n1158, n1157, n1156, n1155, n1154, n1153, n1152, 
        n1151, n1150, n1149, n1148, n1147, n1146, n1145, n1144, n1143, n1142, 
        n1141, n1140, n1139, n1138, n1137}), .B({n1136, n1135, n1134, n1133, 
        n1132, n1131, n1130, n1129, n1128, n1127, n1126, n1125, n1124, n1123, 
        n1122, n1121, n1120, n1119, n1118, n1117, n1116, n1115, n1114, n1113, 
        n1112, n1111, n1110, n1109, n1108, n1107, n1106, n1105}), .Y({n1104, 
        n1103, n1102, n1101, n1100, n1099, n1098, n1097, n1096, n1095, n1094, 
        n1093, n1092, n1091, n1090, n1089, n1088, n1087, n1086, n1085, n1084, 
        n1083, n1082, n1081, n1080, n1079, n1078, n1077, n1076, n1075, n1074, 
        n1073}) );
  TRUN_GEN_C_N8_F14 T1 ( .A({n1072, n1071, n1070, n1069, n1068, n1067, n1066, 
        n1065, n1064, n1063, n1062, n1061, n1060, n1059, n1058, n1057, n1056, 
        n1055, n1054, n1053, n1052, n1051, n1050, n1049, n1048, n1047, n1046, 
        n1045, n1044, n1043, n1042, n1041}), .Y({n1040, n1039, n1038, n1037, 
        n1036, n1035, n1034, n1033, n1032, n1031, n1030, n1029, n1028, n1027, 
        n1026, n1025}) );
  FIR_SFilter Sfilter ( .clock(clock), .reset(reset), .x_in({n1040, n1039, 
        n1038, n1037, n1036, n1035, n1034, n1033, n1032, n1031, n1030, n1029, 
        n1028, n1027, n1026, n1025}), .y_out({n1024, n1023, n1022, n1021, 
        n1020, n1019, n1018, n1017, n1016, n1015, n1014, n1013, n1012, n1011, 
        n1010, n1009}) );
  SUM_GEN_N16 error_adder ( .A(d), .B({n1024, n1023, n1022, n1021, n1020, 
        n1019, n1018, n1017, n1016, n1015, n1014, n1013, n1012, n1011, n1010, 
        n1009}), .Y(e) );
  MULT_GEN_N16 Mult_mi ( .A(e), .B(mi), .Y({n1008, n1007, n1006, n1005, n1004, 
        n1003, n1002, n1001, n1000, n999, n998, n997, n996, n995, n994, n993, 
        n992, n991, n990, n989, n988, n987, n986, n985, n984, n983, n982, n981, 
        n980, n979, n978, n977}) );
  TRUN_GEN_C_N8_F14 T_mi ( .A({n1008, n1007, n1006, n1005, n1004, n1003, n1002, 
        n1001, n1000, n999, n998, n997, n996, n995, n994, n993, n992, n991, 
        n990, n989, n988, n987, n986, n985, n984, n983, n982, n981, n980, n979, 
        n978, n977}), .Y({n976, n975, n974, n973, n972, n971, n970, n969, n968, 
        n967, n966, n965, n964, n963, n962, n961}) );
  MULT_GEN2_N16 \gen_coef_update[0].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B(x), .Y({n960, n959, n958, n957, n956, n955, n954, n953, n952, n951, 
        n950, n949, n948, n947, n946, n945, n944, n943, n942, n941, n940, n939, 
        n938, n937, n936, n935, n934, n933, n932, n931, n930, n929}) );
  SUM_GEN_N32 \gen_coef_update[0].Sum_w  ( .A({n960, n959, n958, n957, n956, 
        n955, n954, n953, n952, n951, n950, n949, n948, n947, n946, n945, n944, 
        n943, n942, n941, n940, n939, n938, n937, n936, n935, n934, n933, n932, 
        n931, n930, n929}), .B({n640, n639, n638, n637, n636, n635, n634, n633, 
        n632, n631, n630, n629, n628, n627, n626, n625, n624, n623, n622, n621, 
        n620, n619, n618, n617, n616, n615, n614, n613, n612, n611, n610, n609}), .Y({n320, n319, n318, n317, n316, n315, n314, n313, n312, n311, n310, n309, 
        n308, n307, n306, n305, n304, n303, n302, n301, n300, n299, n298, n297, 
        n296, n295, n294, n293, n292, n291, n290, n289}) );
  REG_N32 \gen_coef_update[0].R_we  ( .clock(clock), .CL(reset), .A({n320, 
        n319, n318, n317, n316, n315, n314, n313, n312, n311, n310, n309, n308, 
        n307, n306, n305, n304, n303, n302, n301, n300, n299, n298, n297, n296, 
        n295, n294, n293, n292, n291, n290, n289}), .S({n640, n639, n638, n637, 
        n636, n635, n634, n633, n632, n631, n630, n629, n628, n627, n626, n625, 
        n624, n623, n622, n621, n620, n619, n618, n617, n616, n615, n614, n613, 
        n612, n611, n610, n609}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[0].T_we  ( .A({n640, n639, n638, n637, 
        n636, n635, n634, n633, n632, n631, n630, n629, n628, n627, n626, n625, 
        n624, n623, n622, n621, n620, n619, n618, n617, n616, n615, n614, n613, 
        n612, n611, n610, n609}), .Y({n1648, n1647, n1646, n1645, n1644, n1643, 
        n1642, n1641, n1640, n1639, n1638, n1637, n1636, n1635, n1634, n1633})
         );
  MULT_GEN2_N16 \gen_coef_update[1].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1792, n1791, n1790, n1789, n1788, n1787, n1786, n1785, n1784, 
        n1783, n1782, n1781, n1780, n1779, n1778, n1777}), .Y({n928, n927, 
        n926, n925, n924, n923, n922, n921, n920, n919, n918, n917, n916, n915, 
        n914, n913, n912, n911, n910, n909, n908, n907, n906, n905, n904, n903, 
        n902, n901, n900, n899, n898, n897}) );
  SUM_GEN_N32 \gen_coef_update[1].Sum_w  ( .A({n928, n927, n926, n925, n924, 
        n923, n922, n921, n920, n919, n918, n917, n916, n915, n914, n913, n912, 
        n911, n910, n909, n908, n907, n906, n905, n904, n903, n902, n901, n900, 
        n899, n898, n897}), .B({n608, n607, n606, n605, n604, n603, n602, n601, 
        n600, n599, n598, n597, n596, n595, n594, n593, n592, n591, n590, n589, 
        n588, n587, n586, n585, n584, n583, n582, n581, n580, n579, n578, n577}), .Y({n288, n287, n286, n285, n284, n283, n282, n281, n280, n279, n278, n277, 
        n276, n275, n274, n273, n272, n271, n270, n269, n268, n267, n266, n265, 
        n264, n263, n262, n261, n260, n259, n258, n257}) );
  REG_N32 \gen_coef_update[1].R_we  ( .clock(clock), .CL(reset), .A({n288, 
        n287, n286, n285, n284, n283, n282, n281, n280, n279, n278, n277, n276, 
        n275, n274, n273, n272, n271, n270, n269, n268, n267, n266, n265, n264, 
        n263, n262, n261, n260, n259, n258, n257}), .S({n608, n607, n606, n605, 
        n604, n603, n602, n601, n600, n599, n598, n597, n596, n595, n594, n593, 
        n592, n591, n590, n589, n588, n587, n586, n585, n584, n583, n582, n581, 
        n580, n579, n578, n577}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[1].T_we  ( .A({n608, n607, n606, n605, 
        n604, n603, n602, n601, n600, n599, n598, n597, n596, n595, n594, n593, 
        n592, n591, n590, n589, n588, n587, n586, n585, n584, n583, n582, n581, 
        n580, n579, n578, n577}), .Y({n1632, n1631, n1630, n1629, n1628, n1627, 
        n1626, n1625, n1624, n1623, n1622, n1621, n1620, n1619, n1618, n1617})
         );
  MULT_GEN2_N16 \gen_coef_update[2].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1776, n1775, n1774, n1773, n1772, n1771, n1770, n1769, n1768, 
        n1767, n1766, n1765, n1764, n1763, n1762, n1761}), .Y({n896, n895, 
        n894, n893, n892, n891, n890, n889, n888, n887, n886, n885, n884, n883, 
        n882, n881, n880, n879, n878, n877, n876, n875, n874, n873, n872, n871, 
        n870, n869, n868, n867, n866, n865}) );
  SUM_GEN_N32 \gen_coef_update[2].Sum_w  ( .A({n896, n895, n894, n893, n892, 
        n891, n890, n889, n888, n887, n886, n885, n884, n883, n882, n881, n880, 
        n879, n878, n877, n876, n875, n874, n873, n872, n871, n870, n869, n868, 
        n867, n866, n865}), .B({n576, n575, n574, n573, n572, n571, n570, n569, 
        n568, n567, n566, n565, n564, n563, n562, n561, n560, n559, n558, n557, 
        n556, n555, n554, n553, n552, n551, n550, n549, n548, n547, n546, n545}), .Y({n256, n255, n254, n253, n252, n251, n250, n249, n248, n247, n246, n245, 
        n244, n243, n242, n241, n240, n239, n238, n237, n236, n235, n234, n233, 
        n232, n231, n230, n229, n228, n227, n226, n225}) );
  REG_N32 \gen_coef_update[2].R_we  ( .clock(clock), .CL(reset), .A({n256, 
        n255, n254, n253, n252, n251, n250, n249, n248, n247, n246, n245, n244, 
        n243, n242, n241, n240, n239, n238, n237, n236, n235, n234, n233, n232, 
        n231, n230, n229, n228, n227, n226, n225}), .S({n576, n575, n574, n573, 
        n572, n571, n570, n569, n568, n567, n566, n565, n564, n563, n562, n561, 
        n560, n559, n558, n557, n556, n555, n554, n553, n552, n551, n550, n549, 
        n548, n547, n546, n545}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[2].T_we  ( .A({n576, n575, n574, n573, 
        n572, n571, n570, n569, n568, n567, n566, n565, n564, n563, n562, n561, 
        n560, n559, n558, n557, n556, n555, n554, n553, n552, n551, n550, n549, 
        n548, n547, n546, n545}), .Y({n1616, n1615, n1614, n1613, n1612, n1611, 
        n1610, n1609, n1608, n1607, n1606, n1605, n1604, n1603, n1602, n1601})
         );
  MULT_GEN2_N16 \gen_coef_update[3].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1760, n1759, n1758, n1757, n1756, n1755, n1754, n1753, n1752, 
        n1751, n1750, n1749, n1748, n1747, n1746, n1745}), .Y({n864, n863, 
        n862, n861, n860, n859, n858, n857, n856, n855, n854, n853, n852, n851, 
        n850, n849, n848, n847, n846, n845, n844, n843, n842, n841, n840, n839, 
        n838, n837, n836, n835, n834, n833}) );
  SUM_GEN_N32 \gen_coef_update[3].Sum_w  ( .A({n864, n863, n862, n861, n860, 
        n859, n858, n857, n856, n855, n854, n853, n852, n851, n850, n849, n848, 
        n847, n846, n845, n844, n843, n842, n841, n840, n839, n838, n837, n836, 
        n835, n834, n833}), .B({n544, n543, n542, n541, n540, n539, n538, n537, 
        n536, n535, n534, n533, n532, n531, n530, n529, n528, n527, n526, n525, 
        n524, n523, n522, n521, n520, n519, n518, n517, n516, n515, n514, n513}), .Y({n224, n223, n222, n221, n220, n219, n218, n217, n216, n215, n214, n213, 
        n212, n211, n210, n209, n208, n207, n206, n205, n204, n203, n202, n201, 
        n200, n199, n198, n197, n196, n195, n194, n193}) );
  REG_N32 \gen_coef_update[3].R_we  ( .clock(clock), .CL(reset), .A({n224, 
        n223, n222, n221, n220, n219, n218, n217, n216, n215, n214, n213, n212, 
        n211, n210, n209, n208, n207, n206, n205, n204, n203, n202, n201, n200, 
        n199, n198, n197, n196, n195, n194, n193}), .S({n544, n543, n542, n541, 
        n540, n539, n538, n537, n536, n535, n534, n533, n532, n531, n530, n529, 
        n528, n527, n526, n525, n524, n523, n522, n521, n520, n519, n518, n517, 
        n516, n515, n514, n513}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[3].T_we  ( .A({n544, n543, n542, n541, 
        n540, n539, n538, n537, n536, n535, n534, n533, n532, n531, n530, n529, 
        n528, n527, n526, n525, n524, n523, n522, n521, n520, n519, n518, n517, 
        n516, n515, n514, n513}), .Y({n1600, n1599, n1598, n1597, n1596, n1595, 
        n1594, n1593, n1592, n1591, n1590, n1589, n1588, n1587, n1586, n1585})
         );
  MULT_GEN2_N16 \gen_coef_update[4].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1744, n1743, n1742, n1741, n1740, n1739, n1738, n1737, n1736, 
        n1735, n1734, n1733, n1732, n1731, n1730, n1729}), .Y({n832, n831, 
        n830, n829, n828, n827, n826, n825, n824, n823, n822, n821, n820, n819, 
        n818, n817, n816, n815, n814, n813, n812, n811, n810, n809, n808, n807, 
        n806, n805, n804, n803, n802, n801}) );
  SUM_GEN_N32 \gen_coef_update[4].Sum_w  ( .A({n832, n831, n830, n829, n828, 
        n827, n826, n825, n824, n823, n822, n821, n820, n819, n818, n817, n816, 
        n815, n814, n813, n812, n811, n810, n809, n808, n807, n806, n805, n804, 
        n803, n802, n801}), .B({n512, n511, n510, n509, n508, n507, n506, n505, 
        n504, n503, n502, n501, n500, n499, n498, n497, n496, n495, n494, n493, 
        n492, n491, n490, n489, n488, n487, n486, n485, n484, n483, n482, n481}), .Y({n192, n191, n190, n189, n188, n187, n186, n185, n184, n183, n182, n181, 
        n180, n179, n178, n177, n176, n175, n174, n173, n172, n171, n170, n169, 
        n168, n167, n166, n165, n164, n163, n162, n161}) );
  REG_N32 \gen_coef_update[4].R_we  ( .clock(clock), .CL(reset), .A({n192, 
        n191, n190, n189, n188, n187, n186, n185, n184, n183, n182, n181, n180, 
        n179, n178, n177, n176, n175, n174, n173, n172, n171, n170, n169, n168, 
        n167, n166, n165, n164, n163, n162, n161}), .S({n512, n511, n510, n509, 
        n508, n507, n506, n505, n504, n503, n502, n501, n500, n499, n498, n497, 
        n496, n495, n494, n493, n492, n491, n490, n489, n488, n487, n486, n485, 
        n484, n483, n482, n481}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[4].T_we  ( .A({n512, n511, n510, n509, 
        n508, n507, n506, n505, n504, n503, n502, n501, n500, n499, n498, n497, 
        n496, n495, n494, n493, n492, n491, n490, n489, n488, n487, n486, n485, 
        n484, n483, n482, n481}), .Y({n1584, n1583, n1582, n1581, n1580, n1579, 
        n1578, n1577, n1576, n1575, n1574, n1573, n1572, n1571, n1570, n1569})
         );
  MULT_GEN2_N16 \gen_coef_update[5].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1728, n1727, n1726, n1725, n1724, n1723, n1722, n1721, n1720, 
        n1719, n1718, n1717, n1716, n1715, n1714, n1713}), .Y({n800, n799, 
        n798, n797, n796, n795, n794, n793, n792, n791, n790, n789, n788, n787, 
        n786, n785, n784, n783, n782, n781, n780, n779, n778, n777, n776, n775, 
        n774, n773, n772, n771, n770, n769}) );
  SUM_GEN_N32 \gen_coef_update[5].Sum_w  ( .A({n800, n799, n798, n797, n796, 
        n795, n794, n793, n792, n791, n790, n789, n788, n787, n786, n785, n784, 
        n783, n782, n781, n780, n779, n778, n777, n776, n775, n774, n773, n772, 
        n771, n770, n769}), .B({n480, n479, n478, n477, n476, n475, n474, n473, 
        n472, n471, n470, n469, n468, n467, n466, n465, n464, n463, n462, n461, 
        n460, n459, n458, n457, n456, n455, n454, n453, n452, n451, n450, n449}), .Y({n160, n159, n158, n157, n156, n155, n154, n153, n152, n151, n150, n149, 
        n148, n147, n146, n145, n144, n143, n142, n141, n140, n139, n138, n137, 
        n136, n135, n134, n133, n132, n131, n130, n129}) );
  REG_N32 \gen_coef_update[5].R_we  ( .clock(clock), .CL(reset), .A({n160, 
        n159, n158, n157, n156, n155, n154, n153, n152, n151, n150, n149, n148, 
        n147, n146, n145, n144, n143, n142, n141, n140, n139, n138, n137, n136, 
        n135, n134, n133, n132, n131, n130, n129}), .S({n480, n479, n478, n477, 
        n476, n475, n474, n473, n472, n471, n470, n469, n468, n467, n466, n465, 
        n464, n463, n462, n461, n460, n459, n458, n457, n456, n455, n454, n453, 
        n452, n451, n450, n449}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[5].T_we  ( .A({n480, n479, n478, n477, 
        n476, n475, n474, n473, n472, n471, n470, n469, n468, n467, n466, n465, 
        n464, n463, n462, n461, n460, n459, n458, n457, n456, n455, n454, n453, 
        n452, n451, n450, n449}), .Y({n1568, n1567, n1566, n1565, n1564, n1563, 
        n1562, n1561, n1560, n1559, n1558, n1557, n1556, n1555, n1554, n1553})
         );
  MULT_GEN2_N16 \gen_coef_update[6].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1712, n1711, n1710, n1709, n1708, n1707, n1706, n1705, n1704, 
        n1703, n1702, n1701, n1700, n1699, n1698, n1697}), .Y({n768, n767, 
        n766, n765, n764, n763, n762, n761, n760, n759, n758, n757, n756, n755, 
        n754, n753, n752, n751, n750, n749, n748, n747, n746, n745, n744, n743, 
        n742, n741, n740, n739, n738, n737}) );
  SUM_GEN_N32 \gen_coef_update[6].Sum_w  ( .A({n768, n767, n766, n765, n764, 
        n763, n762, n761, n760, n759, n758, n757, n756, n755, n754, n753, n752, 
        n751, n750, n749, n748, n747, n746, n745, n744, n743, n742, n741, n740, 
        n739, n738, n737}), .B({n448, n447, n446, n445, n444, n443, n442, n441, 
        n440, n439, n438, n437, n436, n435, n434, n433, n432, n431, n430, n429, 
        n428, n427, n426, n425, n424, n423, n422, n421, n420, n419, n418, n417}), .Y({n128, n127, n126, n125, n124, n123, n122, n121, n120, n119, n118, n117, 
        n116, n115, n114, n113, n112, n111, n110, n109, n108, n107, n106, n105, 
        n104, n103, n102, n101, n100, n99, n98, n97}) );
  REG_N32 \gen_coef_update[6].R_we  ( .clock(clock), .CL(reset), .A({n128, 
        n127, n126, n125, n124, n123, n122, n121, n120, n119, n118, n117, n116, 
        n115, n114, n113, n112, n111, n110, n109, n108, n107, n106, n105, n104, 
        n103, n102, n101, n100, n99, n98, n97}), .S({n448, n447, n446, n445, 
        n444, n443, n442, n441, n440, n439, n438, n437, n436, n435, n434, n433, 
        n432, n431, n430, n429, n428, n427, n426, n425, n424, n423, n422, n421, 
        n420, n419, n418, n417}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[6].T_we  ( .A({n448, n447, n446, n445, 
        n444, n443, n442, n441, n440, n439, n438, n437, n436, n435, n434, n433, 
        n432, n431, n430, n429, n428, n427, n426, n425, n424, n423, n422, n421, 
        n420, n419, n418, n417}), .Y({n1552, n1551, n1550, n1549, n1548, n1547, 
        n1546, n1545, n1544, n1543, n1542, n1541, n1540, n1539, n1538, n1537})
         );
  MULT_GEN2_N16 \gen_coef_update[7].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1696, n1695, n1694, n1693, n1692, n1691, n1690, n1689, n1688, 
        n1687, n1686, n1685, n1684, n1683, n1682, n1681}), .Y({n736, n735, 
        n734, n733, n732, n731, n730, n729, n728, n727, n726, n725, n724, n723, 
        n722, n721, n720, n719, n718, n717, n716, n715, n714, n713, n712, n711, 
        n710, n709, n708, n707, n706, n705}) );
  SUM_GEN_N32 \gen_coef_update[7].Sum_w  ( .A({n736, n735, n734, n733, n732, 
        n731, n730, n729, n728, n727, n726, n725, n724, n723, n722, n721, n720, 
        n719, n718, n717, n716, n715, n714, n713, n712, n711, n710, n709, n708, 
        n707, n706, n705}), .B({n416, n415, n414, n413, n412, n411, n410, n409, 
        n408, n407, n406, n405, n404, n403, n402, n401, n400, n399, n398, n397, 
        n396, n395, n394, n393, n392, n391, n390, n389, n388, n387, n386, n385}), .Y({n96, n95, n94, n93, n92, n91, n90, n89, n88, n87, n86, n85, n84, n83, 
        n82, n81, n80, n79, n78, n77, n76, n75, n74, n73, n72, n71, n70, n69, 
        n68, n67, n66, n65}) );
  REG_N32 \gen_coef_update[7].R_we  ( .clock(clock), .CL(reset), .A({n96, n95, 
        n94, n93, n92, n91, n90, n89, n88, n87, n86, n85, n84, n83, n82, n81, 
        n80, n79, n78, n77, n76, n75, n74, n73, n72, n71, n70, n69, n68, n67, 
        n66, n65}), .S({n416, n415, n414, n413, n412, n411, n410, n409, n408, 
        n407, n406, n405, n404, n403, n402, n401, n400, n399, n398, n397, n396, 
        n395, n394, n393, n392, n391, n390, n389, n388, n387, n386, n385}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[7].T_we  ( .A({n416, n415, n414, n413, 
        n412, n411, n410, n409, n408, n407, n406, n405, n404, n403, n402, n401, 
        n400, n399, n398, n397, n396, n395, n394, n393, n392, n391, n390, n389, 
        n388, n387, n386, n385}), .Y({n1536, n1535, n1534, n1533, n1532, n1531, 
        n1530, n1529, n1528, n1527, n1526, n1525, n1524, n1523, n1522, n1521})
         );
  MULT_GEN2_N16 \gen_coef_update[8].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1680, n1679, n1678, n1677, n1676, n1675, n1674, n1673, n1672, 
        n1671, n1670, n1669, n1668, n1667, n1666, n1665}), .Y({n704, n703, 
        n702, n701, n700, n699, n698, n697, n696, n695, n694, n693, n692, n691, 
        n690, n689, n688, n687, n686, n685, n684, n683, n682, n681, n680, n679, 
        n678, n677, n676, n675, n674, n673}) );
  SUM_GEN_N32 \gen_coef_update[8].Sum_w  ( .A({n704, n703, n702, n701, n700, 
        n699, n698, n697, n696, n695, n694, n693, n692, n691, n690, n689, n688, 
        n687, n686, n685, n684, n683, n682, n681, n680, n679, n678, n677, n676, 
        n675, n674, n673}), .B({n384, n383, n382, n381, n380, n379, n378, n377, 
        n376, n375, n374, n373, n372, n371, n370, n369, n368, n367, n366, n365, 
        n364, n363, n362, n361, n360, n359, n358, n357, n356, n355, n354, n353}), .Y({n64, n63, n62, n61, n60, n59, n58, n57, n56, n55, n54, n53, n52, n51, 
        n50, n49, n48, n47, n46, n45, n44, n43, n42, n41, n40, n39, n38, n37, 
        n36, n35, n34, n33}) );
  REG_N32 \gen_coef_update[8].R_we  ( .clock(clock), .CL(reset), .A({n64, n63, 
        n62, n61, n60, n59, n58, n57, n56, n55, n54, n53, n52, n51, n50, n49, 
        n48, n47, n46, n45, n44, n43, n42, n41, n40, n39, n38, n37, n36, n35, 
        n34, n33}), .S({n384, n383, n382, n381, n380, n379, n378, n377, n376, 
        n375, n374, n373, n372, n371, n370, n369, n368, n367, n366, n365, n364, 
        n363, n362, n361, n360, n359, n358, n357, n356, n355, n354, n353}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[8].T_we  ( .A({n384, n383, n382, n381, 
        n380, n379, n378, n377, n376, n375, n374, n373, n372, n371, n370, n369, 
        n368, n367, n366, n365, n364, n363, n362, n361, n360, n359, n358, n357, 
        n356, n355, n354, n353}), .Y({n1520, n1519, n1518, n1517, n1516, n1515, 
        n1514, n1513, n1512, n1511, n1510, n1509, n1508, n1507, n1506, n1505})
         );
  MULT_GEN2_N16 \gen_coef_update[9].Mult_w  ( .A({n976, n975, n974, n973, n972, 
        n971, n970, n969, n968, n967, n966, n965, n964, n963, n962, n961}), 
        .B({n1664, n1663, n1662, n1661, n1660, n1659, n1658, n1657, n1656, 
        n1655, n1654, n1653, n1652, n1651, n1650, n1649}), .Y({n672, n671, 
        n670, n669, n668, n667, n666, n665, n664, n663, n662, n661, n660, n659, 
        n658, n657, n656, n655, n654, n653, n652, n651, n650, n649, n648, n647, 
        n646, n645, n644, n643, n642, n641}) );
  SUM_GEN_N32 \gen_coef_update[9].Sum_w  ( .A({n672, n671, n670, n669, n668, 
        n667, n666, n665, n664, n663, n662, n661, n660, n659, n658, n657, n656, 
        n655, n654, n653, n652, n651, n650, n649, n648, n647, n646, n645, n644, 
        n643, n642, n641}), .B({n352, n351, n350, n349, n348, n347, n346, n345, 
        n344, n343, n342, n341, n340, n339, n338, n337, n336, n335, n334, n333, 
        n332, n331, n330, n329, n328, n327, n326, n325, n324, n323, n322, n321}), .Y({n32, n31, n30, n29, n28, n27, n26, n25, n24, n23, n22, n21, n20, n19, 
        n18, n17, n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, n4, 
        n3, n2, n1}) );
  REG_N32 \gen_coef_update[9].R_we  ( .clock(clock), .CL(reset), .A({n32, n31, 
        n30, n29, n28, n27, n26, n25, n24, n23, n22, n21, n20, n19, n18, n17, 
        n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, n5, n4, n3, n2, n1}), .S({n352, n351, n350, n349, n348, n347, n346, n345, n344, n343, n342, n341, 
        n340, n339, n338, n337, n336, n335, n334, n333, n332, n331, n330, n329, 
        n328, n327, n326, n325, n324, n323, n322, n321}) );
  TRUN_GEN_C_N8_F14 \gen_coef_update[9].T_we  ( .A({n352, n351, n350, n349, 
        n348, n347, n346, n345, n344, n343, n342, n341, n340, n339, n338, n337, 
        n336, n335, n334, n333, n332, n331, n330, n329, n328, n327, n326, n325, 
        n324, n323, n322, n321}), .Y({n1504, n1503, n1502, n1501, n1500, n1499, 
        n1498, n1497, n1496, n1495, n1494, n1493, n1492, n1491, n1490, n1489})
         );
  REG_N16 R_OUT ( .clock(clock), .CL(reset), .A({n1040, n1039, n1038, n1037, 
        n1036, n1035, n1034, n1033, n1032, n1031, n1030, n1029, n1028, n1027, 
        n1026, n1025}), .S(y) );
  MULT_UNS_OP \*cell*547  ( .A({1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1}), .B({n1104, n1103, n1102, n1101, n1100, n1099, n1098, n1097, n1096, n1095, 
        n1094, n1093, n1092, n1091, n1090, n1089, n1088, n1087, n1086, n1085, 
        n1084, n1083, n1082, n1081, n1080, n1079, n1078, n1077, n1076, n1075, 
        n1074, n1073}), .Z({n1072, n1071, n1070, n1069, n1068, n1067, n1066, 
        n1065, n1064, n1063, n1062, n1061, n1060, n1059, n1058, n1057, n1056, 
        n1055, n1054, n1053, n1052, n1051, n1050, n1049, n1048, n1047, n1046, 
        n1045, n1044, n1043, n1042, n1041}) );
endmodule


module ANC ( clock, reset, x_in, dn, mi, en, out );
  input [15:0] x_in;
  input [15:0] dn;
  input [15:0] mi;
  output [15:0] en;
  output [15:0] out;
  input clock, reset;
  wire   net11361, net11362, net11363, net11364, net11365, net11366, net11367,
         net11368, net11369, net11370, net11371, net11372, net11373, net11374,
         net11375, net11376, net11377, net11378, net11379, net11380, net11381,
         net11382, net11383, net11384, net11385, net11386, net11387, net11388,
         net11389, net11390, net11391, net11392, net11393, net11394, net11395,
         net11396, net11397, net11398, net11399, net11400, net11401, net11402,
         net11403, net11404, net11405, net11406, net11407, net11408, net11409,
         net11410, net11411, net11412, net11413, net11414, net11415, net11416,
         net11417, net11418, net11419, net11420, net11421, net11422, net11423,
         net11424, net11425, net11426, net11427, net11428, net11429, net11430,
         net11431, net11432, net11433, net11434, net11435, net11436, net11437,
         net11438, net11439, net11440, net11441, net11442, net11443, net11444,
         net11445, net11446, net11447, net11448, net11449, net11450, net11451,
         net11452, net11453, net11454, net11455, net11456, net11457, net11458,
         net11459, net11460, net11461, net11462, net11463, net11464, net11465,
         net11466, net11467, net11468, net11469, net11470, net11471, net11472,
         net11473, net11474, net11475, net11476, net11477, net11478, net11479,
         net11480, net11481, net11482, net11483, net11484, net11485, net11486,
         net11487, net11488, net11532, net11533, net11534, net11535, net11536,
         net11537, net11538, net11539, net11540, net11541, net11542, net11543,
         net11544, net11545, net11546, net11547, net11548, net11549, net11550,
         net11551, net11552, net11553, net11554, net11555, net11556, net11557,
         net11558, net11559, net11560, net11561, net11562, net11563, net11564,
         net11565, net11566, net11567, net11568, net11569, net11570, net11571,
         net11572, net11573, net11574, net11575, net11576, net11577, net11578,
         net11579, net11580, net11581, net11582, net11762, net11763, net11764,
         net11765, net11766, net11767, net11768, net11769, net11770, net11771,
         net11772, net11773, net11774, net11775, net11776, net11777, net11778,
         net11779, net11780, net11781, net11782, net11783, net11784, net11785,
         net11786, net11787, net11788, net11789, net11790, net11791, net11792,
         net11793, net11794, net11795, net11796, net11797, net11798, net11799,
         net11800, net11801, net11802, net11803, net11804, net11805, net11806,
         net11807, net11808, net11809, net11810, net11811, net11812, net11813,
         net11814, net11815, net11816, net11817, net11818, net11819, net11820,
         net11821, net11822, net11823, net11824, net11825, net11930, net11931,
         net11932, net11933, net11934, net11935, net11936, net11937, net11938,
         net11939, net11940, net11941, net11942, net11943, net11944, net11945,
         net11946, net11947, net11948, net11949, net11950, net11951, net11952,
         net11953, net11954, net11955, net11956, net11957, net11958, net11959,
         net11960, net11961, net11962, net11963, net11964, net11965, net11966,
         net11967, net11968, net11969, net11970, net11971, net11972, net11973,
         net11974, net11975, net11976, net11977, net11978, net11979, net11980,
         net11981, net11982, net11983, net11984, net11985, net11986, net11987,
         net11988, net11989, net11990, net11991, net11992, net11993, net11994,
         net11995, net11996, net11997, net11998, net11999, net12000, net12001,
         net12002, net12003, net12004, net12005, net12006, net12007, net12008,
         net12009, net12010, net12011, net12012, net12013, net12014, net12015,
         net12016, net12017, net12018, net12019, net12020, net12021, net12022,
         net12023, net12024, net12025, net12026, net12027, net12028, net12138,
         net12139, net12140, net12141, net12142, net12143, net12144, net12145,
         net12146, net12147, net12148, net12149, net12150, net12151, net12152,
         net12153, net12154, net12155, net12156, net12157, net12158, net12159,
         net12160, net12161, net12162, net12163, net12164, net12165, net12166,
         net12167, net12168, net12169, net12170, net12171, net12172, net12173,
         net12174, net12175, net12176, net12177, net12178, net12179, net12180,
         net12181, net12182, net12183, net12184, net12185, net12186, net12187,
         net12188, net12189, net12190, net12191, net12192, net12193, net12194,
         net12195, net12196, net12197, net12198, net12199, net12200, net12201,
         net12202, net12203, net12204, net12205, net12206, net12207, net12208,
         net12209, net12210, net12211, net12212, net12213, net12214, net12215,
         net12216, net12217, net12218, net12219, net12220, net12221, net12222,
         net12223, net12224, net12225, net12226, net12227, net12228, net12229,
         net12230, net12231, net12232, net12233, net12234, net12235, net12236,
         net12237, net12238, net12239, net12283, net12284, net12285, net12286,
         net12287, net12288, net12289, net12290, net12291, net12292, net12293,
         net12294, net12295, net12296, net12297, net12298, net12299, net12300,
         net12301, net12302, net12303, net12304, net12305, net12306, net12307,
         net12308, net12309, net12310, net12311, net12312, net12313, net12314,
         net12315, net12316, net12317, net12318, net12319, net12320, net12321,
         net12322, net12323, net12324, net12325, net12326, net12327, net12328,
         net12329, net12330, net12331, net12332, net12333, net12949, net12950,
         net12951, net12952, net12953, net12954, net12955, net12956, net12957,
         net12958, net12959, net12960, net12961, net12962, net12963, net12964,
         net12965, net12966, net12967, net12968, net12969, net12970, net12971,
         net12972, net12973, net12974, net12975, net12976, net12977, net12978,
         net12979, net12980, net12981, net12982, net12983, net12984, net12985,
         net12986, net12987, net12988, net12989, net12990, net12991, net12992,
         net12993, net12994, net12995, net12996, net12997, net12998, net12999,
         net13000, net13001, net13002, net13003, net13004, net13005, net13006,
         net13007, net13008, net13009, net13010, net13011, net13012, net13013,
         net13014, net13015, net13016, net13017, net13018, net13019, net13020,
         net13021, net13022, net13023, net13024, net13025, net13026, net13027,
         net13028, net13029, net13030, net13031, net13032, net13033, net13034,
         net13035, net13036, net13037, net13038, net13039, net13040, net13041,
         net13042, net13043, net13044, net13045, net13046, net13047, net13048,
         net13049, net13050, net13051, net13052, net13053, net13054, net13055,
         net13056, net13057, net13058, net13059, net13060, net13061, net13062,
         net13063, net13064, net13065, net13066, net13067, net13068, net13069,
         net13070, net13071, net13072, net13073, net13074, net13075, net13076,
         net13120, net13121, net13122, net13123, net13124, net13125, net13126,
         net13127, net13128, net13129, net13130, net13131, net13132, net13133,
         net13134, net13135, net13136, net13137, net13138, net13139, net13140,
         net13141, net13142, net13143, net13144, net13145, net13146, net13147,
         net13148, net13149, net13150, net13151, net13152, net13153, net13154,
         net13155, net13156, net13157, net13158, net13159, net13160, net13161,
         net13162, net13163, net13164, net13165, net13166, net13167, net13168,
         net13169, net13170, net13350, net13351, net13352, net13353, net13354,
         net13355, net13356, net13357, net13358, net13359, net13360, net13361,
         net13362, net13363, net13364, net13365, net13366, net13367, net13368,
         net13369, net13370, net13371, net13372, net13373, net13374, net13375,
         net13376, net13377, net13378, net13379, net13380, net13381, net13382,
         net13383, net13384, net13385, net13386, net13387, net13388, net13389,
         net13390, net13391, net13392, net13393, net13394, net13395, net13396,
         net13397, net13398, net13399, net13400, net13401, net13402, net13403,
         net13404, net13405, net13406, net13407, net13408, net13409, net13410,
         net13411, net13412, net13413, net13518, net13519, net13520, net13521,
         net13522, net13523, net13524, net13525, net13526, net13527, net13528,
         net13529, net13530, net13531, net13532, net13533, net13534, net13535,
         net13536, net13537, net13538, net13539, net13540, net13541, net13542,
         net13543, net13544, net13545, net13546, net13547, net13548, net13549,
         net13550, net13551, net13552, net13553, net13554, net13555, net13556,
         net13557, net13558, net13559, net13560, net13561, net13562, net13563,
         net13564, net13565, net13566, net13567, net13568, net13569, net13570,
         net13571, net13572, net13573, net13574, net13575, net13576, net13577,
         net13578, net13579, net13580, net13581, net13582, net13583, net13584,
         net13585, net13586, net13587, net13588, net13589, net13590, net13591,
         net13592, net13593, net13594, net13595, net13596, net13597, net13598,
         net13599, net13600, net13601, net13602, net13603, net13604, net13605,
         net13606, net13607, net13608, net13609, net13610, net13611, net13612,
         net13613, net13614, net13615, net13616, net13726, net13727, net13728,
         net13729, net13730, net13731, net13732, net13733, net13734, net13735,
         net13736, net13737, net13738, net13739, net13740, net13741, net13742,
         net13743, net13744, net13745, net13746, net13747, net13748, net13749,
         net13750, net13751, net13752, net13753, net13754, net13755, net13756,
         net13757, net13758, net13759, net13760, net13761, net13762, net13763,
         net13764, net13765, net13766, net13767, net13768, net13769, net13770,
         net13771, net13772, net13773, net13774, net13775, net13776, net13777,
         net13778, net13779, net13780, net13781, net13782, net13783, net13784,
         net13785, net13786, net13787, net13788, net13789, net13790, net13791,
         net13792, net13793, net13794, net13795, net13796, net13797, net13798,
         net13799, net13800, net13801, net13802, net13803, net13804, net13805,
         net13806, net13807, net13808, net13809, net13810, net13811, net13812,
         net13813, net13814, net13815, net13816, net13817, net13818, net13819,
         net13820, net13821, net13822, net13823, net13824, net13825, net13826,
         net13827, net13871, net13872, net13873, net13874, net13875, net13876,
         net13877, net13878, net13879, net13880, net13881, net13882, net13883,
         net13884, net13885, net13886, net13887, net13888, net13889, net13890,
         net13891, net13892, net13893, net13894, net13895, net13896, net13897,
         net13898, net13899, net13900, net13901, net13902, net13903, net13904,
         net13905, net13906, net13907, net13908, net13909, net13910, net13911,
         net13912, net13913, net13914, net13915, net13916, net13917, net13918,
         net13919, net13920, net13921;

  LMS_Direct_10taps W_filter ( .clock(clock), .reset(reset), .x(x_in), .d(dn), 
        .mi(mi), .e(en), .y(out) );
endmodule


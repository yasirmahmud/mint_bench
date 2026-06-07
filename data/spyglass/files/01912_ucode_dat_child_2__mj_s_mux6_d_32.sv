`define F20_MB_CONST_02 4'h8
`define F20_MB_CONST_03 4'h9
`define F20_MB_CONST_04 4'hA
`define F20_MB_CONST_08 4'hB
`define F20_MB_CONST_12 4'hC
`define F20_MB_CONST_16 4'hD
`define F20_MB_CONST_20 4'hE
`define F20_MB_CONST_28 4'hF

`define F06_A_CONST_01 4'h8
`define F06_A_CONST_02 4'h9
`define F06_A_CONST_03 4'hA
`define F06_A_CONST_04 4'hB
`define F06_A_CONST_08 4'hC
`define F06_A_CONST_12 4'hD
`define F06_A_CONST_16 4'hE
`define F06_A_CONST_32 4'hF

`define F15_WT_AREG0_B1 1'b1
`define F11_WT_REG0_A   3'd0
`define F11_WT_REG1_A   3'd1
`define F11_WT_REG2_A   3'd2
`define F11_WT_REG3_A   3'd3

// ---------------------------------------------------------------------------
// Helper Modules to resolve ErrorAnalyzeBBox violations
// ---------------------------------------------------------------------------

module mj_s_mux6_d_32 (
  output [31:0] mx_out,
  input  [2:0]  sel,
  input  [31:0] in0,
  input  [31:0] in1,
  input  [31:0] in2,
  input  [31:0] in3,
  input  [31:0] in4,
  input  [31:0] in5
);
  assign mx_out = (sel == 3'd0) ? in0 :
                  (sel == 3'd1) ? in1 :
                  (sel == 3'd2) ? in2 :
                  (sel == 3'd3) ? in3 :
                  (sel == 3'd4) ? in4 :
                  (sel == 3'd5) ? in5 :
                                  in0; // Default to in0 for undefined select values
endmodule

module curve_wrn_66_20260111_181100_296200_w37940_attempt8 (
  output [31:0] result_val1,
  output [31:0] result_val2
);

  wire [31:0] temp_val1;
  wire [31:0] temp_val2;

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  assign temp_val1 = 0'd0; 
  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  assign temp_val2 = 0'd0; 

  assign result_val1 = temp_val1;
  assign result_val2 = temp_val2;

endmodule

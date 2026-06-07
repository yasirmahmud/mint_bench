module curve_wrn_66_20260111_181100_296200_w37940_attempt10 (
  output [31:0] out_wire_val,
  output [31:0] out_reg_val
);

  wire [31:0] internal_wire;
  reg  [31:0] internal_reg;

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  assign internal_wire = 0'd0;

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  always @* begin
    internal_reg = 0'd0;
  end

  assign out_wire_val = internal_wire;
  assign out_reg_val  = internal_reg;

endmodule

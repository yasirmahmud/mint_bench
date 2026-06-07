module curve_wrn_66_20260111_221343_156114_w28836_attempt12 (
  output wire [31:0] out_wire_val,
  output reg [31:0] out_reg_val
);

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  assign out_wire_val = 0'd0;

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  always @* begin
    out_reg_val = 0'd0;
  end

endmodule

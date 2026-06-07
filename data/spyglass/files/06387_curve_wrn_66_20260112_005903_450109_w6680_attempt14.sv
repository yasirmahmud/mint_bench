module curve_wrn_66_20260112_005903_450109_w6680_attempt14 (
  input clk,
  input rst_n,
  output [31:0] out_wire_val,
  output reg [31:0] out_reg_val
);

  // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
  assign out_wire_val = 0'd0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg_val <= 32'b0; // This assignment will not trigger WRN_66
    end else begin
      // WRN_66: Zero width specification of based number (0'd0) is ignored, width is assumed to be <32> bits
      out_reg_val <= 0'd0;
    end
  end

endmodule

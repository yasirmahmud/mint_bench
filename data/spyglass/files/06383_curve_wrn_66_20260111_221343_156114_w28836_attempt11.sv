module curve_wrn_66_20260111_221343_156114_w28836_attempt11 (
  input wire clk,
  input wire rst_n,
  output reg [31:0] out_val1,
  output reg [31:0] out_val2
);

  wire [31:0] intermediate_wire1;
  wire [31:0] intermediate_wire2;

  // WRN_66: Zero width specification of based number ( 0'd0 ) is ignored, width is assumed to be < 32 > bits
  assign intermediate_wire1 = 0'd0;

  // WRN_66: Zero width specification of based number ( 0'd0 ) is ignored, width is assumed to be < 32 > bits
  assign intermediate_wire2 = 0'd0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_val1 <= 32'd0;
      out_val2 <= 32'd0;
    end else begin
      out_val1 <= intermediate_wire1;
      out_val2 <= intermediate_wire2;
    end
  end

endmodule

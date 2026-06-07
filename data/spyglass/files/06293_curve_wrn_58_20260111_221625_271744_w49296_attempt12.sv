module curve_wrn_58_20260111_221625_271744_w49296_attempt12 (
  input wire clk,
  input wire rst_n,
  output wire [31:0] out_data
);

  // WRN_58 (Occurrence 1):
  // The unsized decimal literal 2147483648 (which is 2^31) is implicitly treated
  // as a 32-bit signed integer by Verilog-2001. This value exceeds the maximum
  // positive capacity for a 32-bit signed integer (2^31 - 1 or 2147483647),
  // triggering WRN_58 at the literal definition point.
  localparam OVERFLOW_VALUE = 2147483648;

  reg [31:0] data_reg;

  // Use clk and rst_n to avoid unused signal warnings.
  // Use OVERFLOW_VALUE to prevent an unused localparam warning.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 32'd0;
    end else begin
      data_reg <= OVERFLOW_VALUE;
    end
  end

  assign out_data = data_reg;

endmodule

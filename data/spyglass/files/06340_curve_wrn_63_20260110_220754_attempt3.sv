module curve_wrn_63_20260110_220754_attempt3 (
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  output wire [7:0] out_c,
  output reg [7:0] out_d
);

  // WRN_63 occurrence 1: Division by zero in a continuous assignment
  // This expression will result in a division by zero warning.
  assign out_c = in_a / 8'd0;

  // WRN_63 occurrence 2: Division by zero in a procedural block
  // This expression within the always block will also result in a division by zero warning.
  always @(*) begin
    if (in_b > 8'd10) begin
      out_d = (in_b + 8'd5) / 8'd0;
    end else begin
      // Assign a default value to avoid a latch and ensure all paths are covered
      out_d = in_a;
    end
  end

endmodule

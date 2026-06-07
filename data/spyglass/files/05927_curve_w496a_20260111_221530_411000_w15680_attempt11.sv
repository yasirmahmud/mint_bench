module curve_w496a_20260111_221530_411000_w15680_attempt11 (
  input wire in_1,
  input wire [1:0] in_2,
  input wire [2:0] in_3,
  output reg out_1,
  output reg out_2,
  output reg out_3
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  // This module triggers exactly 3 instances of W496a by comparing inputs
  // with different bit-width tristate values (1'bz, 2'bz0, 3'b1z1) within an always_comb block.
  always @(*) begin
    // Default assignments to prevent latches
    out_1 = 1'b0;
    out_2 = 1'b0;
    out_3 = 1'b0;

    // Violation 1: Comparison of a 1-bit input with a fully tristate value
    if (in_1 == 1'bz) begin
      out_1 = 1'b1;
    end

    // Violation 2: Comparison of a 2-bit input with a partially tristate value
    if (in_2 == 2'bz0) begin
      out_2 = 1'b1;
    end

    // Violation 3: Comparison of a 3-bit input with another partially tristate value
    if (in_3 == 3'b1z1) begin
      out_3 = 1'b1;
    end
  end

endmodule

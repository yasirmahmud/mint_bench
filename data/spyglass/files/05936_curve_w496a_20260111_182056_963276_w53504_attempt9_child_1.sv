module curve_w496a_20260111_182056_963276_w53504_attempt9 (
  input wire [1:0] in_a,
  input wire [1:0] in_b,
  input wire [1:0] in_c,
  output reg out_p,
  output reg out_q,
  output reg out_r
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  always @(*) begin
    // Violation 1: Comparing with a partially tristate value
    // Fix: Use case equality (===) to compare with 'z' values to preserve the functional behavior of matching a tristate value in simulation.
    if (in_a === 2'b0z) begin
      out_p = 1'b1;
    end else begin
      out_p = 1'b0;
    end

    // Violation 2: Comparing with a partially tristate value
    // Fix: Use case equality (===) to compare with 'z' values to preserve the functional behavior of matching a tristate value in simulation.
    if (in_b === 2'bz1) begin
      out_q = 1'b1;
    end else begin
      out_q = 1'b0;
    end

    // Violation 3: Comparing with a fully tristate value
    // Fix: Use case equality (===) to compare with 'z' values to preserve the functional behavior of matching a tristate value in simulation.
    if (in_c === 2'bzz) begin
      out_r = 1'b1;
    end else begin
      out_r = 1'b0;
    end
  end

endmodule

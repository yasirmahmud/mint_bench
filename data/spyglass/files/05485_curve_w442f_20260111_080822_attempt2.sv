module curve_w442f_20260111_080822_attempt2 (
  input wire clk,
  input wire set_a,
  input wire set_b,
  input wire data_in,
  output reg data_out
);

  // W442f violation: The asynchronous set condition uses the binary operator '^'
  // in its validation, instead of only '==' or '!='.
  always_ff @(posedge clk or posedge (set_a ^ set_b)) begin
    if (set_a ^ set_b) begin // Violation: W442f
      data_out <= 1'b1;
    end else begin
      data_out <= data_in;
    end
  end

endmodule

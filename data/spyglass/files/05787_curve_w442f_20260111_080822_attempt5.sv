module curve_w442f_20260111_080822_attempt5 (
  input wire clk,
  input wire rst_a,
  input wire rst_b,
  input wire data_in,
  output reg data_out
);

  // W442f violation: The asynchronous reset condition uses the binary operator '^'
  // in its validation, instead of only '==' or '!='.
  always @(posedge clk or posedge (rst_a ^ rst_b)) begin
    if (rst_a ^ rst_b) begin // Violation: W442f
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule

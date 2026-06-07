module curve_starc05_2_3_1_6_20260111_191259_572783_w53504_attempt6 (
  input wire clk,
  input wire reset_sig,
  input wire data_in,
  output reg data_out
);

  wire reset_cond = ~reset_sig; // Intermediate wire for inverted reset

  always @(posedge clk or posedge reset_sig) begin // Sensitivity list implies active-high reset
    if (reset_cond) begin // Condition checks for active-low state (reset_sig is low)
      data_out <= 1'b0; // Reset value
    end else begin
      data_out <= data_in; // Normal operation
    end
  end

endmodule

module curve_starc05_2_3_1_6_20260111_191259_572783_w53504_attempt7 (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  // STARC05-2.3.1.6: The sensitivity list specifies 'posedge rst',
  // implying an active-high asynchronous reset.
  // However, the 'if' condition checks 'if (~rst)', which means the reset is active-low.
  // This mismatch between the reset's edge in the sensitivity list and its logic level check
  // triggers the STARC05-2.3.1.6 violation.
  always @(posedge clk or posedge rst) begin
    if (~rst) begin // Mismatch: sensitivity implies active-high, condition checks active-low
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule

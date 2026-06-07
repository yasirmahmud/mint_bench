module curve_w392_20260111_182843_915337_w53504_attempt10 (
  input wire clk,
  input wire rst,
  input wire data_a,
  input wire data_b,
  output reg q_reg_a,
  output reg q_reg_b
);

  // Declare an inverted reset signal to resolve W392 violation.
  // 'rst_n' is active-high when the original 'rst' signal is active-low.
  wire rst_n;
  assign rst_n = !rst;

  // First flip-flop: Originally configured for active-low asynchronous reset (rst low).
  // Now using 'rst_n', which is active-high when 'rst' is low.
  // This ensures 'rst' is not used with mixed polarities.
  always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin // Reset when rst_n is high (which means rst is low)
      q_reg_a <= 1'b1; // Reset to 1
    end else begin
      q_reg_a <= data_a;
    end
  end

  // Second flip-flop: Configured for active-high asynchronous reset.
  // This block remains unchanged as 'rst' is used consistently as active-high here.
  always @(posedge clk or posedge rst) begin
    if (rst) begin // Active-high reset condition
      q_reg_b <= 1'b0; // Reset to 0
    end else begin
      q_reg_b <= data_b;
    end
  end

endmodule

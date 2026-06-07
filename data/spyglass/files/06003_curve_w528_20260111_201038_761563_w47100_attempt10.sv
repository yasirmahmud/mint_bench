module curve_w528_20260111_201038_761563_w47100_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare a register that will be assigned a value but never read.
  reg [7:0] unused_sequential_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      unused_sequential_reg <= 8'h00; // Reset it to avoid uninitialized state warnings
      data_out <= 8'h00; // Reset data_out to avoid latches if not assigned
    end else begin
      // 'unused_sequential_reg' is assigned (set) here.
      // This assignment will trigger W528 because the variable is never read.
      unused_sequential_reg <= data_in + 8'd1; 

      // 'data_out' uses 'data_in' to ensure 'data_in' is not unused.
      // It also ensures 'data_out' itself is properly driven.
      data_out <= data_in;
    end
  end

  // 'unused_sequential_reg' is never read by any other logic,
  // leading to exactly one W528 violation.

endmodule

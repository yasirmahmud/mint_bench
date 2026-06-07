module curve_w352_20260112_012928_111180_w47152_attempt18 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] internal_data;
  integer i; // Loop variable (Verilog-2001 style)

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
      internal_data <= 8'h00;
      i <= 0; // Initialize 'i' to avoid W481a (unused signal)
    end else begin
      // Basic data path to ensure module ports are used
      internal_data <= data_in;
      data_out <= internal_data;

      // Ensure 'i' is explicitly used outside the 'for' loop to avoid W481a (unused signal)
      // This operation does not affect the W352 violation.
      i <= i + 1;

      // W352 violation: The 'for' condition (5 > 10) is constant (always false).
      // The loop will never execute.
      // This is distinct from previous examples by using a constant comparison
      // of two distinct numerical literals with a 'greater than' operator.
      for (i = 0; (5 > 10); i = i + 1) begin
        // This code block is unreachable as the loop condition is constant false.
        // No further logic is needed here to trigger W352.
      end
    end
  end

endmodule

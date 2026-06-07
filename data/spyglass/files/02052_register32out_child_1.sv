module register32out(
  input [31:0] Parallel_in,
  input clk,
  input rst,
  input enable,
  output [31:0] parallel_out
);

  // Internal register to store the latched data. This register resets to a known value (0).
  reg [31:0] internal_data_reg;

  // Sequential block for the data register, handling clock and reset.
  // This block latches Parallel_in when enabled on the rising clock edge.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_data_reg <= 32'h0; // Reset internal register to a known value, not high-Z.
    end else if (enable) begin
      internal_data_reg <= Parallel_in;
    end
    // If enable is low, internal_data_reg holds its current value.
  end

  // Continuous assignment for the output, implementing the tristate behavior.
  // parallel_out goes to high-impedance when rst is active, otherwise it outputs the latched data.
  assign parallel_out = rst ? 32'dz : internal_data_reg;

endmodule

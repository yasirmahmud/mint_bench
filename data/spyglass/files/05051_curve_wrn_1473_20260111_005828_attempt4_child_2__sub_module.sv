`timescale 1ns / 1ps

module sub_module #(
  parameter P_regular = 10
) (
  input clk // Added for synthesizable sequential logic
);
  // localparam values are fixed and cannot be overridden by defparam.
  localparam P_local_unoverridable = P_regular + 5;

  // Internal logic to avoid WarnAnalyzeBBox for empty module
  // Changed to 1-bit reg for synthesizable clocking
  reg internal_reg;
  wire [7:0] computed_val;
  assign computed_val = P_local_unoverridable + P_regular;

  // Minimal logic to make the module non-empty without causing other violations
  // Changed to use an explicit clock and assign LSB of computed_val
  always @(posedge clk) begin
    internal_reg <= computed_val[0]; // Assign LSB to 1-bit register
  end

endmodule

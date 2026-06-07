`timescale 1ns / 1ps

module sub_module #(
  parameter P_regular = 10
);
  // localparam values are fixed and cannot be overridden by defparam.
  localparam P_local_unoverridable = P_regular + 5;

  // Internal logic to avoid WarnAnalyzeBBox for empty module
  reg [7:0] internal_reg;
  wire [7:0] computed_val;
  assign computed_val = P_local_unoverridable + P_regular;

  // Minimal logic to make the module non-empty without causing other violations
  always @(posedge internal_reg) begin
    internal_reg <= computed_val;
  end

endmodule

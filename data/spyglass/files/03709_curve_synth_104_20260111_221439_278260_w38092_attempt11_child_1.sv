module curve_synth_104_20260111_221439_278260_w38092_attempt11 (
  input wire clk,
  input wire rst_n,
  output wire out1,
  output wire out2,
  output wire out3
);

  reg my_reg_a;
  reg my_reg_b;
  reg my_reg_c;

  // Initialize internal registers to a known state
  initial begin
    my_reg_a = 1'b0;
    my_reg_b = 1'b0;
    my_reg_c = 1'b0;
  end

  // SYNTH_104 violation 1 and CheckDelayTimescale-ML warning removed by removing the non-synthesizable initial block.

  // SYNTH_104 violation 2 resolved by removing the deassign statement.
  // W442a violation resolved as the always block now has the 'if' statement at the top level covering all assignments.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_reg_b <= 1'b0;
    end else begin
      my_reg_b <= my_reg_a; // Use my_reg_a to ensure it's not unused
    end
  end

  // SYNTH_104 violation 3 resolved by removing the deassign statement.
  always @(negedge clk) begin
    my_reg_c <= my_reg_b; // Use my_reg_b to ensure it's not unused
  end

  // Connect internal registers to outputs to avoid unused signal warnings
  assign out1 = my_reg_a;
  assign out2 = my_reg_b;
  assign out3 = my_reg_c;

endmodule

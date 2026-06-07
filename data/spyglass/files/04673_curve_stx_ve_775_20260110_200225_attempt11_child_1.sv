module curve_stx_ve_775_20260110_200225_attempt11 (
  input clk,
  output reg my_reg1,
  output reg my_reg2
);

  // Initialize my_reg1 outside the always block
  initial begin
    my_reg1 = 1'b0;
  end

  // Synchronous logic for my_reg1
  always @(posedge clk) begin
    my_reg1 <= ~my_reg1;
  end

  // Initialize my_reg2 outside the always block
  initial begin
    my_reg2 = 1'b1;
  end

  // Synchronous logic for my_reg2
  always @(posedge clk) begin
    my_reg2 <= my_reg1; // Dummy logic to ensure my_reg2 is used
  end

endmodule

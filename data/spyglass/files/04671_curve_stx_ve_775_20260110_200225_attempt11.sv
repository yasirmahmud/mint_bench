module curve_stx_ve_775_20260110_200225_attempt11 (
  input clk,
  output reg my_reg1,
  output reg my_reg2
);

  // STX_VE_775: Initial statement not allowed in this scope
  // An initial block is a top-level procedural block and cannot be nested within an always block.
  always @(posedge clk) begin
    initial begin // First occurrence of STX_VE_775
      my_reg1 = 1'b0;
    end
    my_reg1 <= ~my_reg1;
  end

  // STX_VE_775: Initial statement not allowed in this scope
  // An initial block is a top-level procedural block and cannot be nested within an always block.
  always @(posedge clk) begin
    initial begin // Second occurrence of STX_VE_775
      my_reg2 = 1'b1;
    end
    my_reg2 <= my_reg1; // Dummy logic to ensure my_reg2 is used
  end

endmodule

module w216_ex1 (
  input wire clk,
  input wire rst_n, // Asynchronous active-low reset is commonly used for initial values
  output wire i_0_out // Output to observe the value of i[0]
);

  reg i_reg; // Changed from reg [31:0] to reg (single bit) to resolve W528 (variable set but not read).
             // The original behavior only read i[0], so matching the register size to its usage addresses this.

  // Replaced the 'initial' block with a synchronous reset to make the design synthesizable.
  // This resolves SYNTH_5143 (Initial block is ignored for synthesis).
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      i_reg <= 1'b0; // Decimal 10 in binary is ...01010. Its LSB (bit 0) is 0.
                     // This preserves the functional behavior that i[0] is 0 upon initialization.
    end
    // No 'else' block, so i_reg will hold its reset value indefinitely after reset deassertion.
  end

  // Exposing i_reg as an output allows its value to be observed in a synthesizable design,
  // functionally replacing the $display statement from the original simulation-only context.
  assign i_0_out = i_reg;

endmodule

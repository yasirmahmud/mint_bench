module recursive_func_ex1 (input [3:0] a, output [7:0] b);
  // Original recursive function replaced with a synthesizable iterative implementation
  // to resolve SYNTH_5369 violation due to recursion.
  reg [7:0] b_reg;

  always_comb begin
    // W480: Loop index 'i' is not of type integer - FIXED by changing 'reg [3:0] i' to 'integer i'.
    integer i;
    reg [7:0] product_temp;
    // SYNTH_5230: Number of iterations in for-loop exceeds max. allowable limit.
    // FIXED by introducing an integer variable 'a_val' for the loop bound to ensure
    // the tool correctly interprets the integer range of the 4-bit input 'a'.
    integer a_val;

    a_val = a;

    if (a_val <= 1) begin
      product_temp = 1;
    end else begin
      product_temp = 1;
      // Iterate from 2 up to 'a' to calculate factorial
      for (i = 2; i <= a_val; i = i + 1) begin
        product_temp = product_temp * i;
      end
    end
    b_reg = product_temp;
  end

  assign b = b_reg;
endmodule

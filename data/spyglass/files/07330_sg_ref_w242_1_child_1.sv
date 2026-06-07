module recursive_func_ex1 (input [3:0] a, output [7:0] b);
  // Original recursive function replaced with a synthesizable iterative implementation
  // to resolve SYNTH_5369 violation due to recursion.
  reg [7:0] b_reg;

  always_comb begin
    reg [3:0] i;
    reg [7:0] product_temp;

    if (a <= 1) begin
      product_temp = 1;
    end else begin
      product_temp = 1;
      // Iterate from 2 up to 'a' to calculate factorial
      for (i = 2; i <= a; i = i + 1) begin
        product_temp = product_temp * i;
      end
    end
    b_reg = product_temp;
  end

  assign b = b_reg;
endmodule

module ResFunction_ex2 (input wire a, input wire b, output reg out);

  always @(*) begin
    // The original function my_resolution_func(a, b) would return:
    // 0.0 if a=0, b=0
    // 0.5 if a=0, b=1
    // 1.0 if a=1, b=0
    // 1.5 if a=1, b=1
    // The condition (my_resolution_func(a, b) > 0.5) simplifies to just (a == 1'b1).
    // This replacement preserves the original functional behavior while removing non-synthesizable 'real' types.
    out = a;
  end

endmodule

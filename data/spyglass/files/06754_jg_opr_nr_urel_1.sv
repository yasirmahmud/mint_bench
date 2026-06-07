module unequal_compare_lt (
  input [3:0] in_a,
  input [1:0] in_b,
  output reg out_lt
);

  always @* begin
    out_lt = (in_a < in_b); // LHS (4-bit) vs RHS (2-bit)
  end

endmodule

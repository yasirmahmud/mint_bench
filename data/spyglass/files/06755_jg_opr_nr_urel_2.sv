module unequal_compare_ge (
  input [7:0] data_val,
  input [4:0] threshold,
  output reg flag_ge
);

  always @* begin
    flag_ge = (data_val >= threshold); // LHS (8-bit) vs RHS (5-bit)
  end

endmodule

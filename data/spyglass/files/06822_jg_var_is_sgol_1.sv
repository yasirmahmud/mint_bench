module var_is_sgol_unsigned_to_signed;
  logic signed [3:0] s_val;
  // Unsigned constant 4'b1000 (decimal 8)
  // Casting to signed will interpret it as -8, changing the value.
  assign s_val = signed'(4'b1000);
endmodule

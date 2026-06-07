module var_is_sgol_signed_to_unsigned;
  logic unsigned [3:0] u_val;
  // Signed constant 4'sb1000 (decimal -8)
  // Casting to unsigned will interpret it as 8, changing the value.
  assign u_val = unsigned'(4'sb1000);
endmodule

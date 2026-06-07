module int_overflow_neg_example();
  integer my_int;

  initial begin
    my_int = -2147483649; // Exceeds 32-bit signed integer min (-2^31)
  end
endmodule

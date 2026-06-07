module int_overflow_pos_example();
  integer my_int;

  initial begin
    my_int = 2147483648; // Exceeds 32-bit signed integer max (2^31 - 1)
  end
endmodule

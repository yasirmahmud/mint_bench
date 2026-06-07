module int_bit_select_violation();
  integer my_int;
  reg bit_0;

  initial begin
    my_int = 123;
    bit_0 = my_int[0]; // Triggers INT_NR_PSBT
  end
endmodule

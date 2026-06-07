module curve_w215_20260111_002217_attempt4 ();

  integer my_int;
  reg bit_reg_0;
  reg bit_reg_1;
  reg bit_reg_2;
  reg bit_reg_3;

  initial begin
    my_int = 32'hFEEDFACE; // Assign an arbitrary value to the integer
    // Each instance of bit selection on the 'integer' type variable
    // 'my_int' directly triggers a W215 violation.
    bit_reg_0 = my_int[0]; // Triggers W215: Inappropriate bit select for int_bit_sel variable
    bit_reg_1 = my_int[1]; // Triggers W215: Inappropriate bit select for int_bit_sel variable
    bit_reg_2 = my_int[2]; // Triggers W215: Inappropriate bit select for int_bit_sel variable
    bit_reg_3 = my_int[3]; // Triggers W215: Inappropriate bit select for int_bit_sel variable
  end

endmodule

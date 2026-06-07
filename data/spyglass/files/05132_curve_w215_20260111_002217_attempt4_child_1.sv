module curve_w215_20260111_002217_attempt4 (
  output reg bit_reg_0,
  output reg bit_reg_1,
  output reg bit_reg_2,
  output reg bit_reg_3
);

  reg [31:0] my_int; // Changed from integer to sized reg to allow bit selection

  initial begin
    my_int = 32'hFEEDFACE; // Assign an arbitrary value to the integer
    // The W215 violations (Inappropriate bit select for int_bit_sel variable)
    // are resolved by declaring 'my_int' as a sized 'reg' type.
    bit_reg_0 = my_int[0];
    bit_reg_1 = my_int[1];
    bit_reg_2 = my_int[2];
    bit_reg_3 = my_int[3];
    // The W528 violations (Variable set but not read) are resolved by
    // declaring 'bit_reg_X' as module outputs, making them observable.
  end

endmodule

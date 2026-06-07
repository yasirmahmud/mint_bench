module int_part_select_violation();
  integer counter;
  reg [7:0] lower_byte;

  initial begin
    counter = 500;
    lower_byte = counter[7:0]; // Triggers INT_NR_PSBT
  end
endmodule

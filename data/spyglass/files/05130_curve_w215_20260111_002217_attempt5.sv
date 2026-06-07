module curve_w215_20260111_002217_attempt5 (
  input [31:0] data_in,
  output reg   bit_out
);

  integer my_int;

  // Using an always @* block to ensure synthesizability and avoid SYNTH_5143.
  // 'my_int' is assigned from 'data_in' and its bit is selected.
  // 'bit_out' is an output, preventing W528 (unused variable).
  always @* begin
    my_int = data_in;    // Assign an input to the integer variable
    bit_out = my_int[0]; // Triggers exactly one W215: Inappropriate bit select for int_bit_sel variable
  end

endmodule

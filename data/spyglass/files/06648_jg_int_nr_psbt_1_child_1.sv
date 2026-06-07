module int_bit_select_violation (
  output reg bit_0
);
  reg [31:0] my_int; // Changed from 'integer' to 'reg [31:0]' to allow explicit bit selection

  initial begin
    my_int = 123;
    bit_0 = my_int[0]; // Valid bit selection now
  end
endmodule

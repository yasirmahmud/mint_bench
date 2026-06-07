module unequal_op_or (
  input [5:0] data_in,
  output [7:0] data_out
);

  reg [7:0] temp_reg;

  always_comb begin
    temp_reg = data_in | 8'hFF; // 'data_in' is 6 bits, '8'hFF' is 8 bits. Unequal length operands for bitwise OR.
    data_out = temp_reg;
  end

endmodule

module casex_example_04(
  input [0:0] single_bit_in,
  output reg single_bit_out
);
  always @* begin
    casex (single_bit_in)
      1'bx: single_bit_out = 1'b1;
      1'b0: single_bit_out = 1'b0;
    endcase
  end
endmodule

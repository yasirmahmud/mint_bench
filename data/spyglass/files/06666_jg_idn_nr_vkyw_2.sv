module reserved_word_as_reg (
  input data_in,
  output reg data_out
);
  reg initial; // 'initial' is a Verilog reserved word

  always @* begin
    initial = data_in;
  end

  assign data_out = initial;
endmodule

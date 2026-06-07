module example_09 (input valid, input data_i, output logic data_o);
  always @* begin
    if (valid) data_o <= data_i;
  end
endmodule

module test16(input [7:0] data_in);
  reg [7:0] data_out_reg;
  assign data_out_reg = data_in << 1;
endmodule

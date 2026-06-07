module test6(input [3:0] val_in);
  reg [3:0] val_out_reg;
  assign val_out_reg = val_in + 4'd1;
endmodule

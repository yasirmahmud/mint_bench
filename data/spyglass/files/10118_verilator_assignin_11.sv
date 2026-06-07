module example_11(input k);
  reg [0:0] k_reg;
  always @* k_reg = 1'b0;
  assign k = k_reg;
endmodule

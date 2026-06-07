module test12(input enable);
  reg status_reg;
  assign status_reg = enable ? 1'b1 : 1'b0;
endmodule

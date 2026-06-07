module test18(input cond, input val1, input val2);
  reg mux_out_reg;
  assign mux_out_reg = cond ? val1 : val2;
endmodule

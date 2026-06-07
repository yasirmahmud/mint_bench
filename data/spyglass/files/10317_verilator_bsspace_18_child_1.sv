module test18;
  `define CONDITIONAL_ASSIGN (enable) ? \
  data_in : 0
  logic enable, data_in, data_out;
  assign data_out = `CONDITIONAL_ASSIGN;
endmodule

module sub_module;
  parameter [5:0] P = 6'h0;

  localparam integer LP_PARAM_PLUS_ONE = P + 1;

  output [31:0] out_val;
  assign out_val = LP_PARAM_PLUS_ONE;
endmodule

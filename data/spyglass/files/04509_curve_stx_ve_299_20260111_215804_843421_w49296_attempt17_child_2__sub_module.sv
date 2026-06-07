module sub_module (
  output [31:0] out_val
);
  parameter [5:0] P = 6'h0;

  localparam integer LP_PARAM_PLUS_ONE = P + 1;

  assign out_val = LP_PARAM_PLUS_ONE;
endmodule

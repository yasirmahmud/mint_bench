module NoParamMultConcat_ex1 (
  output [P-1:0] out
);
  parameter P = 2;
  assign out = { P {1'b1}};
endmodule

module NoParamMultConcat_ex1;
 parameter P = 2;
 wire [P-1:0] out;
 assign out = { P {1'b1}};
 endmodule

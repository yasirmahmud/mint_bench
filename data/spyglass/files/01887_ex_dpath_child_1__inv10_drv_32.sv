module inv10_drv_32(out, in);
  output [31:0] out;
  input  [31:0] in;
  assign out = ~in;
endmodule

module compare_zero_32(in, out);
  input  [31:0] in;
  output        out;
  assign out = (in == 32'h0);
endmodule

module cmp_32(gt, eq, lt, in1, in2, sign);
  output        gt, eq, lt;
  input  [31:0] in1, in2;
  input         sign;
  
  wire [31:0] s_in1 = sign ? $signed(in1) : in1;
  wire [31:0] s_in2 = sign ? $signed(in2) : in2;
  
  assign eq = (s_in1 == s_in2);
  assign gt = (s_in1 >  s_in2);
  assign lt = (s_in1 <  s_in2);
endmodule

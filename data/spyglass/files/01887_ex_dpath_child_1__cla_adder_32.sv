module cla_adder_32(cout, sum, in1, in2, cin);
  output        cout;
  output [31:0] sum;
  input  [31:0] in1, in2;
  input         cin;
  assign {cout, sum} = in1 + in2 + cin;
endmodule

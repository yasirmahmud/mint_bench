// Dummy cla_adder_28 for linting
module cla_adder_28 (input [27:0] in1, in2,
                     input cin,
                     output cout,
                     output [27:0] sum);
  assign {cout, sum} = in1 + in2 + cin;
endmodule

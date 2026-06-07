module PortCheck_ML_ex2 (input in_port, input a, input b);
 wire and_out;
 and (and_out, a, b);
 assign in_port = and_out;
 endmodule

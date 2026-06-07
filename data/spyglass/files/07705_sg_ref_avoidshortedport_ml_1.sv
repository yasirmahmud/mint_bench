module AvoidShortedPort_ML_ex1;
 wire s;
 wire out_and;
 and (out_and, s, s);
 assign s = 1'b0;
 endmodule

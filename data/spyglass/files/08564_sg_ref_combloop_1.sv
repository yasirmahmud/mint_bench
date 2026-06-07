module comb_loop_ex1(input [0:0] i, output [0:0] o);
 wire w;
 assign w = ~i[0];
 assign o[0] = w;
 assign i[0] = ~o[0];
 endmodule

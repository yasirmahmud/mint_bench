module mixedsenselist_ex2 (input clock, input reset, input d, output reg q);
 always @(posedge clock or reset) q = d;
 endmodule

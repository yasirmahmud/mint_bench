module mixedsenselist_ex2 (input clock, input reset, input d, output reg q);
 always @(posedge clock or posedge reset) q = d;
 endmodule

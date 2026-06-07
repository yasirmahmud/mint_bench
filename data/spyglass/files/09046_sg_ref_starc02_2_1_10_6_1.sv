module STARC02_2_1_10_6_ex1 (output reg out);
 reg [1:0] sel_static;
 initial begin sel_static = 2'b01;
 case (sel_static) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule

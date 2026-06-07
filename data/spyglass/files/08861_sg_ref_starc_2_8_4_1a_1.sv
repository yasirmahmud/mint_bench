module star_2_8_4_1a_ex1 (input [1:0] sel, output reg out);
 always @(*) begin casex (sel) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 2'b10: out = 1'b0;
 2'b11: out = 1'b1;
 endcasex end endmodule

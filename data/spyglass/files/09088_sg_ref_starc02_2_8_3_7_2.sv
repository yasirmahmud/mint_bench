module star_ex2 (input [1:0] in_a, output reg out_b);
 wire [1:0] sel_x;
 assign sel_x = 2'b0x;
 always @(*) begin casex (sel_x) 2'b00: out_b = in_a[0];
 2'b01: out_b = in_a[1];
 default: out_b = 1'b0;
 endcasex end endmodule

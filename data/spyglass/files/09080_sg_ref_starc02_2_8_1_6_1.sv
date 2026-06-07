module star_c02_2_8_1_6_ex1(sel, out);
input [3:0] sel;
output out;
reg out;
parameter [2:0] P = 3'b001;
always @(*) begin case (sel) P: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule

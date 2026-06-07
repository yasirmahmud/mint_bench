module st_2_1_6_4_ex1(out,in,clk);
input [3:0]in;
input clk;
output [3:0]out;
reg [3:0]out;
wire i;
always @(posedge clk) out[i]=in[i];
endmodule

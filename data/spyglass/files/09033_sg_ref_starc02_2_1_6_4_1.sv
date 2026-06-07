module star_c02_2_1_6_4_ex1(data_out,data_in,clk);
input clk;
input [3:0] data_in;
output [3:0] data_out;
reg [3:0] data_out;
wire idx;
always @ (posedge clk) data_out[idx] = data_in[idx];
endmodule

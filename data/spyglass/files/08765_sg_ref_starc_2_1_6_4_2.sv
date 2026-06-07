module star_2_1_6_4_ex2(clk, data_in, data_out);
 input clk;
 input [3:0] data_in;
 output [3:0] data_out;
 reg [3:0] data_out;
 wire index_var;
 always @(posedge clk) data_out[index_var] = data_in[index_var];
 endmodule

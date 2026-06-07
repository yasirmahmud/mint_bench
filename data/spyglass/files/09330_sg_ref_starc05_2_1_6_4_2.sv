module star_c05_2_1_6_4_ex2(input clk, input [3:0] data_in, output reg [3:0] data_out);
 wire index_var;
 always @(posedge clk) begin data_out[index_var] = data_in[index_var];
 end endmodule

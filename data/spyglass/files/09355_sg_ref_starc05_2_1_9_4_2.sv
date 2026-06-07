module star_c05_2_1_9_4_ex2(input [7:0] data_in, output reg [7:0] data_out);
 assign data_out = data_in[data_in.size-1:0];
 endmodule

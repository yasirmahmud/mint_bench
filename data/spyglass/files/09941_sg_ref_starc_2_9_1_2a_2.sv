module star_2_9_1_2a_ex2 (input [7:0] data_in, output reg [7:0] data_out);
 integer i;
 always @(*) begin for (i = data_in; i < 8; i = i + 1) begin data_out[i] = data_in[i];
 end end endmodule

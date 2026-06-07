module star_c02_2_1_6_3_ex2(input [1:0] sel, input data_in, output reg data_out);
 reg [7:0] my_array [0:4];
 always @(*) begin my_array[sel + 1] = data_in;
 data_out = my_array[0];
 end endmodule

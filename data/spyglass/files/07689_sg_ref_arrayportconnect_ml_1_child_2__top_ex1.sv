module top_ex1 (input wire [1:0] sel_idx, input wire [7:0] data_in_0, input wire [7:0] data_in_1, input wire [7:0] data_in_2, input wire [7:0] data_in_3);
 reg [7:0] my_array[0:3];
 always @(*) begin my_array[0] = data_in_0;
 my_array[1] = data_in_1;
 my_array[2] = data_in_2;
 my_array[3] = data_in_3;
 end sub_module u_sub (.data_in(my_array[sel_idx]));
 endmodule

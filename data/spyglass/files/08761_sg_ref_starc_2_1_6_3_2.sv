module module_ex2 (input [1:0] index_in, output [7:0] data_out);
 reg [7:0] my_array [0:3];
 assign data_out = my_array[index_in + 1];
 endmodule

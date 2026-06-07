module top_ex2 (input wire [2:0] index_val);
 reg [7:0] multi_dim_array [0:3];
 sub_module inst_sub (.data_in(multi_dim_array[index_val]));
 endmodule

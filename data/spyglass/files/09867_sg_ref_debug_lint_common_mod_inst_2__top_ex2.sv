module top_ex2;
 wire [7:0] data_a, data_b;
 wire [15:0] data_c, data_d;
 my_sub_module #(.WIDTH(8)) inst_a (.in(data_a), .out(data_b));
 my_sub_module #(.WIDTH(16)) inst_b (.in(data_c), .out(data_d));
 endmodule

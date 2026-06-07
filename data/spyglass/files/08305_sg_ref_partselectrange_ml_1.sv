module part_select_range_ml_ex1();
 wire [63:0] data;
 wire [7:0] sub_data;
 assign sub_data = data[50:+8];
 endmodule

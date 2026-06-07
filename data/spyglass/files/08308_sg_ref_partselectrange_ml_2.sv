module part_select_range_ml_ex2;
 wire [63:0] data;
 wire [7:0] selected_data;
 assign data = 64'h0;
 assign selected_data = data[15:+8];
 endmodule

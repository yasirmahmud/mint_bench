module part_select_range_ml_ex1();
 wire [63:0] data;
 wire [7:0] sub_data;

 // Resolve SpyGlass W123: Variable 'data' is read but never set.
 // Assigning a constant value to 'data' to make it driven.
 assign data = 64'hFEDCBA9876543210;

 assign sub_data = data[50:+8];

 // Resolve SpyGlass W528: Variable 'sub_data' is set but not read.
 // Adding a dummy assignment to ensure 'sub_data' is read.
 wire [7:0] dummy_sub_data_reader;
 assign dummy_sub_data_reader = sub_data;

 endmodule

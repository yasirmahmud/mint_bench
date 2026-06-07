module my_module_ex2;
 wire [7:0] data [0:1];
 assign data = '{8'hAA, 8'hBB};

 // Added to resolve W528: Variable 'data' set but not read.
 // This output concatenates the array elements of 'data' to ensure it is read.
 output wire [15:0] data_out_debug;
 assign data_out_debug = {data[1], data[0]};

 endmodule

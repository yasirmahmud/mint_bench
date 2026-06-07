module generate_name_ml_ex2;
 reg [7:0] data;
 generate if (1) begin : my_generate_block_ex2 
  assign data = 8'hFF;
 end endgenerate

 // Fix W528: Variable 'data[7:0]' set but not read.
 // Adding a dummy read to prevent the warning without changing functional behavior.
 wire [7:0] unused_data_reader = data;

endmodule

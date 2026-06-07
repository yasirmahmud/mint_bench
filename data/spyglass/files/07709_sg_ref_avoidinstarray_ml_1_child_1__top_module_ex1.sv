module top_module_ex1;
  // Declare a wire array to connect to the output 'b' of the instance array
  wire [1:0] inst_array_b_out;
  my_sub_module inst_array[0:1] (.a(1'b0), .b(inst_array_b_out));
 endmodule

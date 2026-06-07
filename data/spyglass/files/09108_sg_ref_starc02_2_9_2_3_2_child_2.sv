module starc02_2_9_2_3_ex2 (input [0:0] data_in, input [0:0] my_array [0:100], output reg out_val);
 integer i;
 reg any_array_element_is_high;

 always @(*) begin
  // Use a local temporary variable to accumulate the result of the loop.
  // This resolves the multiple assignment warning for 'any_array_element_is_high'
  // by ensuring 'any_array_element_is_high' is assigned only once within this always block.
  reg temp_any_array_element_is_high = 1'b0;

  for (i = 0; i <= 100; i = i + 1) begin
   if (my_array[i] == 1'b1) begin
    temp_any_array_element_is_high = 1'b1;
    break;
   end
  end
  // Assign to the actual output register only once.
  any_array_element_is_high = temp_any_array_element_is_high;
  out_val = any_array_element_is_high || data_in;
 end
endmodule

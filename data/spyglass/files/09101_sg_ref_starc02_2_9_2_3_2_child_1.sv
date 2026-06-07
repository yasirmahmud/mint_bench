module starc02_2_9_2_3_ex2 (input [0:0] data_in, input [0:0] my_array [0:100], output reg out_val);
 integer i;
 reg any_array_element_is_high;

 always @(*) begin
  any_array_element_is_high = 1'b0;
  for (i = 0; i <= 100; i = i + 1) begin
   if (my_array[i] == 1'b1) begin
    any_array_element_is_high = 1'b1;
    break;
   end
  end
  out_val = any_array_element_is_high || data_in;
 end
endmodule

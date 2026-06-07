module module_ex2 (input [1:0] index_in, output [7:0] data_out);
 reg [7:0] my_array [0:3];

 // Initialize my_array to resolve UndrivenInTerm-ML and W123 violations.
 // Since no specific initialization is described, all elements are set to 0.
 initial begin
  my_array[0] = 8'h00;
  my_array[1] = 8'h00;
  my_array[2] = 8'h00;
  my_array[3] = 8'h00;
 end

 assign data_out = my_array[index_in + 1];
 endmodule

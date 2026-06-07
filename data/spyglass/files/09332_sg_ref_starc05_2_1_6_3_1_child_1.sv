module STARC05_2_1_6_3_ex1(input [2:0] addr, output reg [7:0] data_out);
 reg [7:0] my_array [0:7];

 // Fix: Initialize my_array to resolve undriven violations (STARC05-2.1.6.3, UndrivenInTerm-ML, W123)
 initial begin
  integer i;
  for (i = 0; i <= 7; i = i + 1) begin
   my_array[i] = 8'h00; // Initialize all elements to a known value
  end
 end

 always @* begin data_out = my_array[addr + 1];
 end
endmodule

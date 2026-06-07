module STARC05_2_1_6_3_ex1(input [2:0] addr, output reg [7:0] data_out);
 reg [7:0] my_array [0:7] = '{default: 8'h00}; // Synthesizable initialization to resolve undriven violations

 always @* begin
  data_out = my_array[addr + 1];
 end
endmodule

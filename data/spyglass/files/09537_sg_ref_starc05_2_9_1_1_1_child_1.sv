module star_c05_2_9_1_1_ex1 (input [3:0] a, output reg x);
 integer i;
 reg temp_x;
 always @(*) begin
  temp_x = 1'b1;
  for (i = 0; i <= 3; i = i + 1) begin
   temp_x = temp_x & a[i];
  end
  x = temp_x;
 end
endmodule

module starc05_2_1_6_4_ex1;
 wire [3:0] my_bus;
 wire index;
 wire bit_out;
 assign my_bus = 4'b1010;
 assign index = 1'b0;
 assign bit_out = my_bus[index];
 endmodule

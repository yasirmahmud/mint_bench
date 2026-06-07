module STARC05_2_10_4_6v_ex1;
 reg [7:0] my_data;
 wire flag;
 assign my_data = 8'd10;
 assign flag = (my_data < -5);
 endmodule

module STARC05_2_1_8_2_ex1;
 function my_func_ex1;
 input [7:0] data_in;
 reg [7:0] temp_arr [0:3];
 integer i;
 begin for (i=0; i<4; i=i+1) begin temp_arr[i] = data_in + i;
 end my_func_ex1 = temp_arr;
 end endfunction endmodule

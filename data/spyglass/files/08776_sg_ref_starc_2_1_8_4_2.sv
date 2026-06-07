module st_2_1_8_4_ex2;
 function [1:0] get_array;
 input bit val;
 begin get_array = '{0: val, 1: 1'b0};
 end endfunction reg [1:0] my_result;
 initial begin my_result = get_array(1'b1);
 end endmodule

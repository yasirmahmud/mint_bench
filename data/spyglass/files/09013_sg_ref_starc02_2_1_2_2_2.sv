module stac02_2_1_2_2_ex2 (input [7:0] in_data, output [7:0] out_data);
 function automatic [7:0] my_func;
 input [7:0] func_in;
 reg [7:0] func_result;
 begin func_result <= func_in + 1;
 my_func = func_result;
 end endfunction assign out_data = my_func(in_data);
 endmodule

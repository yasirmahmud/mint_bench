module top_module_ex2(input clk, input [7:0] in_val, output [7:0] out_val);
 reg [3:0] result_reg;
 wire [7:0] func_return;
 function automatic [7:0] my_func_ex2;
 output [7:0] o_data;
 input [7:0] i_data;
 begin o_data = i_data;
 my_func_ex2 = o_data;
 end endfunction assign func_return = my_func_ex2(result_reg, in_val);
 assign out_val = func_return;
 endmodule

module my_module_ex1;
function my_func_ex1;
input [7:0] data_in;
reg [7:0] result_arr [0:1];
begin result_arr[0] = data_in;
result_arr[1] = data_in;
my_func_ex1 = result_arr;
end endfunction endmodule

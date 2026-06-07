module my_module_ex2;
 function [7:0] add_one(input [7:0] in_val);
 add_one = in_val + 1;
 endfunction wire [7:0] out_val = add_one(8'd5);
 endmodule

module my_module_ex2(input a, output [3:0] out);
 function [3:0] my_func;
 input in_val;
 begin if (in_val) begin my_func[0] = 1'b1;
 my_func[1] = 1'b0;
 end else begin my_func[0] = 1'b0;
 my_func[1] = 1'b1;
 end end endfunction assign out = my_func(a);
 endmodule

module my_module_ex2 (input a, output reg b);
 function automatic [7:0] my_func (input [7:0] data);
 begin if (data == 8'd0) disable my_func;
 else my_func = data + 1;
 end endfunction always @(*) begin b = my_func(a)[0];
 end endmodule

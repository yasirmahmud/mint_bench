module while_in_subprog_ex1;
 reg [7:0] data;
 function automatic [7:0] my_func;
 input [7:0] in_data;
 reg [7:0] temp;
 begin temp = in_data;
 while (temp > 0) begin temp = temp - 1;
 end my_func = temp;
 end endfunction initial begin data = my_func(8'd10);
 end endmodule

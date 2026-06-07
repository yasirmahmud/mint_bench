module top_module_ex2;
 reg [7:0] my_unsigned_signal;
 child_ex2 u_child (.data_in(my_unsigned_signal));
 initial my_unsigned_signal = 8'd0;
 endmodule

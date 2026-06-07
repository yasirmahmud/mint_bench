module W254_ex1(input clk, input data, input ref_event);
 specify $setup(data, ref_event, 10);
 endspecify endmodule

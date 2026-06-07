module w253_ex1 (input clk, input data_in, input ref_in);
 specify $setup(posedge data_in, posedge ref_in, 10);
 endspecify endmodule

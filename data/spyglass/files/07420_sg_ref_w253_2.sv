module w253_ex2(input clk, input data_in);
 reg q;
 always @(posedge clk) begin $setup(posedge data_in, posedge clk, 1);
 q <= data_in;
 end endmodule

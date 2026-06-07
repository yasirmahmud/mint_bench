module W256_ex2 (input clk, input data, output out);
 reg [1:0] notifier_reg;
 assign out = data;
 $setup(data, posedge clk, 10, notifier_reg);
 endmodule

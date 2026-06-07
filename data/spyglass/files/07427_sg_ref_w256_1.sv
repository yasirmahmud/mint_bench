module w256_ex1(input clk, input data, input ref);
 reg [1:0] notifier_reg;
 initial begin notifier_reg = 2'b00;
 end $setup(data, posedge clk, 10, notifier_reg);
 endmodule

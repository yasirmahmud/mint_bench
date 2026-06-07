module my_module_ex2(input clk);
 reg [3:0] var1;
 always @(posedge clk) begin var1[1:0] <= {2{1'b1}};
 end endmodule

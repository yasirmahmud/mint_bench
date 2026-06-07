module shared_var_ex2 (input clk);
 reg my_shared_var;
 always @(posedge clk) my_shared_var <= 1'b0;
 always @(posedge clk) my_shared_var <= 1'b1;
 endmodule

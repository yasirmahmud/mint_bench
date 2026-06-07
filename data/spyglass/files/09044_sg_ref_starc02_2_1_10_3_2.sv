module shared_var_ex2 (input clk);
 integer my_counter;
 always @(posedge clk) begin my_counter = my_counter + 1;
 end endmodule

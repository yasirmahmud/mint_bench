module my_module_ex2 (input clk, input rst);
 always @(posedge clk) begin my_task;
 end task my_task;
 @(posedge clk);
 @(negedge rst);
 endtask endmodule

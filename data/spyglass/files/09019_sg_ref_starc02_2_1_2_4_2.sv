module my_module_ex2(input clk, output reg out);
 task my_task;
 begin out = ~out;
 end endtask always @(posedge clk) begin my_task;
 end endmodule

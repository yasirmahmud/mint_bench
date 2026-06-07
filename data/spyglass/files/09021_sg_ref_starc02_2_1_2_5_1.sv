module my_module_ex1(clk, in, out);
 input clk, in;
 output reg out;
 task my_task_with_edge;
 input task_in;
 output reg task_out;
 begin @(posedge clk) task_out = task_in;
 end endtask always @(posedge clk) my_task_with_edge(in, out);
 endmodule

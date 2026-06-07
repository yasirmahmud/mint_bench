module top_ex2 (input clk, input i, output reg o);
 always @(posedge clk) my_task(i, o);
 task my_task;
 input in_a;
 output out_a;
 begin @(posedge clk) out_a = in_a;
 end endtask endmodule

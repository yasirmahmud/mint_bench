module lint_star_ex2(input clk, input in_sig, output reg out_sig);
 task my_task;
 input t_in;
 output t_out;
 begin @(posedge clk) t_out = t_in;
 end endtask always @(posedge clk) begin my_task(in_sig, out_sig);
 end endmodule

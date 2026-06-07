module star_2_1_2_6_ex2(clk, in_sig, out_sig);
 input clk;
 input in_sig;
 output reg out_sig;
 always @(posedge clk) my_task(in_sig, out_sig);
 task my_task;
 input t_in;
 output t_out;
 begin @(posedge clk) t_out = t_in;
 end endtask endmodule

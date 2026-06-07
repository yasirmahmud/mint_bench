module starc_2_1_2_6_ex1(input clk, input in_data, output reg out_data);
 always @(posedge clk) my_task(in_data, out_data);
 task my_task;
 input t_in;
 output t_out;
 begin @(posedge clk) t_out = t_in;
 end endtask endmodule

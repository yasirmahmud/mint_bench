module W428L_ex2 (input clk, rst, in_data, output reg out_q);
 always @(posedge clk or posedge rst) begin if (rst) out_q <= 1'b0;
 else begin my_task;
 out_q <= in_data;
 end end task my_task;
 $display("Task called");
 endtask endmodule

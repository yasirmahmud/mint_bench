module W428L_ex1(input clk, input rst, output reg q);
 always @(posedge clk) begin if (rst) q <= 1'b0;
 else my_task;
 end task my_task;
 $display("Task called");
 endtask endmodule

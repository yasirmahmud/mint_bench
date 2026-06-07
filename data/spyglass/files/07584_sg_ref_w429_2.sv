module W429_ex2 (input clk, input rst_n, output reg out);
 task my_task;
 begin out = 1'b1;
 end endtask always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out <= 1'b0;
 end else begin my_task;
 end end endmodule

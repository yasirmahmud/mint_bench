module st_2_1_2_5_ex1(input clk, input rst, output reg out);
 task my_task;
 out <= 1'b0;
 endtask always @(posedge clk or posedge rst) begin if (rst) out <= 1'b0;
 else begin my_task;
 out <= 1'b1;
 end end endmodule

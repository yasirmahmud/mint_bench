module SigAsgnDelay_ex1 (input clk, rst, in_data, output reg out_data);
 always @(posedge clk or posedge rst) begin if (rst) out_data <= 1'b0;
 else out_data <= #1 in_data;
 end endmodule

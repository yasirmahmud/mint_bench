module STARC05_1_3_1_5b_ex1 (input clk, rst, in, output reg out);
 initial out = 1'b0;
 always @(posedge clk or posedge rst) begin // synopsys async_set_reset "rst"
   if (rst) out <= 1'b0;
   else out <= in;
 end
endmodule

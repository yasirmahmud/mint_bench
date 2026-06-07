module for_loop_wait_ex2(input clk, input rst, output reg [7:0] out_reg);
 integer i;
 reg condition;
 always @(posedge clk) begin if (rst) out_reg <= 8'h0;
 else begin condition = 1'b0;
 for (i = 0; i < 5; i = i + 1) begin wait (condition);
 out_reg <= out_reg + 1;
 end end endmodule

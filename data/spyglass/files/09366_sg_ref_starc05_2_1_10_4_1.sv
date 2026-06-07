module while_loop_ex1(input clk, output reg [3:0] cnt);
 always @(posedge clk) begin cnt = 4'd0;
 while (cnt < 4'd5) begin cnt = cnt + 4'd1;
 end end endmodule

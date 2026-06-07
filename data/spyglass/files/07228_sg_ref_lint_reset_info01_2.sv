module lint_reset_info01_ex2 (input clk, input common_rst_n, output reg q_async, output reg q_sync);
 always @(posedge clk or negedge common_rst_n) begin if (!common_rst_n) begin q_async <= 1'b0;
 end else begin q_async <= ~q_async;
 end end always @(posedge clk) begin if (!common_rst_n) begin q_sync <= 1'b0;
 end else begin q_sync <= ~q_sync;
 end end endmodule

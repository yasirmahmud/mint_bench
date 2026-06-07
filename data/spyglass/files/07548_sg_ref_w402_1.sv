module w402_ex1 (input clk, input rst_in, input enable_gate);
 wire gated_async_rst;
 assign gated_async_rst = rst_in && enable_gate;
 reg data_q;
 always @(posedge clk or posedge gated_async_rst) begin if (gated_async_rst) begin data_q <= 1'b0;
 end else begin data_q <= 1'b1;
 end end endmodule

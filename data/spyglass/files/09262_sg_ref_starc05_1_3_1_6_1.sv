module reset_check_ex1 (input clk, input rst, input data_in, output reg q_async, output reg q_sync);
 always @(posedge clk or negedge rst) begin if (!rst) begin q_async <= 1'b0;
 end else begin q_async <= data_in;
 end end always @(posedge clk) begin if (!rst) begin q_sync <= 1'b0;
 end else begin q_sync <= data_in;
 end end endmodule

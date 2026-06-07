module NoMixedSynch_ex1(clk, reset, data_in, q_async, q_sync);
input clk, reset, data_in;
output q_async, q_sync;
reg q_async, q_sync;
always @(posedge clk or negedge reset) begin if (!reset) begin q_async <= 1'b0;
 end else begin q_async <= data_in;
 end end always @(posedge clk) begin if (reset) begin q_sync <= 1'b0;
 end else begin q_sync <= data_in;
 end end endmodule

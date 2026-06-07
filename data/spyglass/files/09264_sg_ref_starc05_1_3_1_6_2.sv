module my_module_ex2 (input clk, input reset, input data_in, output reg q_async, output reg q_sync);
 always @ (posedge clk or negedge reset) begin if (!reset) q_async <= 1'b0;
 else q_async <= data_in;
 end always @ (posedge clk) begin if (reset) q_sync <= 1'b0;
 else q_sync <= data_in;
 end endmodule

module sequential_input_ex2 (input clk, input rst, input data_in, output [19:0] q_out);
 wire high_fanout_net;
 assign high_fanout_net = data_in;
 genvar i;
 generate for (i = 0; i < 20; i = i + 1) begin : ff_gen always @(posedge clk or posedge rst) begin if (rst) begin q_out[i] <= 1'b0;
 end else begin q_out[i] <= high_fanout_net;
 end end end endgenerate endmodule

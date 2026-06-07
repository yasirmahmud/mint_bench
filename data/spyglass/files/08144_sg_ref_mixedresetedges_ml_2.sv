module mixed_reset_edges_ex2 (input clk, input rst, input data_in, output reg q);
 always @ (posedge clk or posedge rst or negedge rst) begin if (rst) begin q <= 1'b0;
 end else if (!rst) begin q <= 1'b1;
 end else begin q <= data_in;
 end end endmodule

module seq_assign_outside_if_ex1 (input clk, input rst, input in_data, output reg out_data);
 always @(posedge clk) begin out_data = in_data;
 if (rst) begin out_data = 1'b0;
 end end endmodule

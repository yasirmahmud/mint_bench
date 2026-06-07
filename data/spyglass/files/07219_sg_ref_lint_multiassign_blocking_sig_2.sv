module multiassign_ex2 (input clk, input rst, input [7:0] in_data, output reg [7:0] out_data);
 always @(posedge clk or posedge rst) begin if (rst) begin out_data = 8'b0;
 end else begin out_data = in_data;
 out_data = in_data + 1;
 end end endmodule

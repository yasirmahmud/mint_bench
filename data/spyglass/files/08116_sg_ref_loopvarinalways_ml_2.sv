module LoopVarInAlways_ex2(input clk, input rst, output reg [7:0] data_out);
 always @(posedge clk or posedge rst) begin if (rst) begin data_out <= 8'b0;
 end else begin for (integer i = 0; i < 8; i = i + 1) begin data_out[i] <= i[0];
 end end end endmodule

module non_synth_repeat_ex1(input clk, input rst, output reg out);
 always @(posedge clk or posedge rst) begin if (rst) out = 1'b0;
 else repeat(2) out = ~out;
 end endmodule

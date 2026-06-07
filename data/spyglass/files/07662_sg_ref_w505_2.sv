module W505_ex2 (input clk, input d, output reg q);
 always @(posedge clk) begin q = d;
 q <= d;
 end endmodule

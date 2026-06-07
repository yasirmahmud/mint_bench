module my_module_ex1 (input clk, input rst_n, output reg out);
 initial out = 1'b0;
 always @(posedge clk or negedge rst_n) if (!rst_n) out <= 1'b0;
 else out <= ~out;
 endmodule

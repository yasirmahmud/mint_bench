module my_module_ex1 (input clk, input rst_n, input in1, input in2, output reg out1, output reg out2);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) out1 <= 1'b0;
 else begin out1 <= in1;
 out2 <= in2;
 end end endmodule

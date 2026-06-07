module w528_ex2_module(input [1:0] in1, input clk, output reg [1:0] out1);
 wire [1:0] my_unused_var;
 assign my_unused_var = 2'b10;
 always @(posedge clk) begin out1 <= in1;
 end endmodule

module NonBlockAssign_ex1(output reg out, input in, input clk);
always @(posedge clk) out = in;
endmodule

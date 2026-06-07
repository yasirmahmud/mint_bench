module tristate_port_ex2 (input clk, input rst, input in1, output reg out1);
 always @(posedge clk) begin if (rst) out1 = in1;
 else out1 = 1'bz;
 end endmodule

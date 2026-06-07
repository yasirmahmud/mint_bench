module PortUsedBeforeDefine_ex2 (input clk, output reg out_port);
 always @(posedge clk) begin out_port <= in_port;
 end input wire in_port;
 endmodule

module top_module_ex2 #(parameter WIDTH = 8);
 input clk;
 output [WIDTH-1:0] data_out;
 reg [WIDTH-1:0] data_out;
 always @(posedge clk) begin data_out <= WIDTH;
 end endmodule

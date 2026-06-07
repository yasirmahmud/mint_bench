module debug_lint_assign_for_ex2 (input clk, output reg [7:0] data_out1, output reg [7:0] data_out2);
 integer i;
 always @(posedge clk) begin for (i = 0; i < 4; i = i + 1) begin data_out1 = i;
 data_out2 = i + 1;
 end end endmodule

module loop_bound_ex2 (input clk, input rst_n, input [3:0] dynamic_limit, output reg [7:0] counter_out);
 reg [3:0] i;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin counter_out <= 8'h00;
 end else begin for (i = 0; i < dynamic_limit; i = i + 1) begin counter_out <= counter_out + 1;
 end end end endmodule

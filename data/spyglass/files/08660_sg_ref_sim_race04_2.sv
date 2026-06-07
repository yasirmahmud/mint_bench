module sim_race04_ex2 (input clk, output reg [31:0] event_time);
 always @(*) begin event_time = $time;
 end endmodule

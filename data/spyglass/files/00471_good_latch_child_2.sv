module good_latch (input clk , input reset , input d , output reg q);
reg q_internal; // Internal register to implement the latch
assign q = q_internal; // Latch output, or directly use q as reg

// This always block describes the level-sensitive behavior of a latch
always @ (d, clk, reset, q_internal) // All signals that determine the next state of the latch
begin
	if(reset)
		q_internal = 1'b0;
	else if(clk)
		q_internal = d;
	else
		q_internal = q_internal; // Explicitly model the latching behavior when clk is low
end
endmodule

module stopwatch2(
input	clk,
input reset,
input stop,
input record,
output reg ring,
output reg [6:0] sec,
output reg [6:0] min,
output reg [4:0] hour,
output reg [6:0] rec_sec,
output reg [6:0] rec_min,
output reg [4:0] rec_hour
	 );
	 always @ (posedge clk or posedge reset)
		begin
			 if (reset == 1) // Asynchronous reset
				begin
					sec  <= 7'd0; // Corrected bit width for reset value to match [6:0] declaration
					min  <= 7'd0; // Corrected bit width for reset value to match [6:0] declaration
					hour <= 5'd0; // Corrected bit width for reset value to match [4:0] declaration
					ring <= 1'b0;
				end	
			 else
				 begin
						// Preserving original behavior for 'stop':
						// Original: if (stop != 1) {counting} else {ring = 1}
						// This means if stop is 1, ring; otherwise (0, X, Z), count.
						if(stop == 1) begin // If stop is explicitly 1, trigger alert
							ring <= 1'b1;
							// sec, min, hour retain their values when stopped (no assignments here)
						end
						else begin // If stop is not 1 (i.e., 0, X, or Z), continue counting
							ring <= 1'b0; // Clear alert when actively counting
							
							// Logic to increment counters, using non-blocking assignments ('<=') to fix W336
							// and structured to ensure unique assignment paths for W415a.
							// Counts 0-59 for sec/min, 0-12 for hour, then rolls over.
							if (sec == 7'd59) begin // If seconds is 59, it rolls over to 0
								sec <= 7'd0; // Reset seconds
								
								if (min == 7'd59) begin // If minutes is 59, it rolls over to 0
									min <= 7'd0; // Reset minutes
									
									if (hour == 5'd12) begin // If hours is 12, it rolls over to 0 (0-12 range for 13 hours)
										hour <= 5'd0; // Reset hours
									end else begin
										hour <= hour + 1;
									end
								end else begin
									min <= min + 1;
								end
								end else begin
								sec <= sec + 1;
								end
						end
				end
		end
		
		// This block records the time when 'record' goes high.
		// 'reset' is added to sensitivity list and prioritized as an asynchronous clear,
		// resolving STARC05-1.3.1.3 violation.
		always @ (posedge record or posedge reset)
		begin
			if(reset) begin // Asynchronous reset for recorded values
				rec_sec  <= 7'd0; // Use non-blocking assignment and correct bit width
				rec_min  <= 7'd0; // Use non-blocking assignment and correct bit width
				rec_hour <= 5'd0; // Use non-blocking assignment and correct bit width
			end
			else begin // Synchronous operation to posedge record
					rec_sec  <= sec;
					rec_min  <= min;
					rec_hour <= hour;
			end
		end
endmodule

module stopwatch3(
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
	 
	// Internal wires for calculated next states of the counters when they are actively incrementing
	wire [6:0] sec_calculated_next;
	wire [6:0] min_calculated_next;
	wire [4:0] hour_calculated_next;

	// Combinational logic block to determine the next state of the counters
	// (assuming they are actively counting, without considering reset or stop conditions directly here)
	always @* begin
		// Default assignments to prevent latches if not all conditions are met.
		// These assignments reflect that the counter typically holds its value or increments.
		sec_calculated_next = sec;
		min_calculated_next = min;
		hour_calculated_next = hour;

		if (sec == 7'd59) begin // Seconds roll over
			sec_calculated_next = 7'd0;
			if (min == 7'd59) begin // Minutes roll over
				min_calculated_next = 7'd0;
				if (hour == 5'd12) begin // Hours roll over (0-12, 13 states)
					hour_calculated_next = 5'd0;
				end else begin
					hour_calculated_next = hour + 1; // Increment hour
					
				end
			end else begin
				min_calculated_next = min + 1; // Increment minute
				
			end
		end else begin
			sec_calculated_next = sec + 1; // Increment second
			
		end
	end

	 // Sequential logic block for state updates (sec, min, hour, ring)
	 always @ (posedge clk or posedge reset)
		begin
			 if (reset == 1'b1) // Asynchronous reset for main counters and ring
				begin
					sec <= 7'd0;
					min <= 7'd0;
					hour <= 5'd0;
					ring <= 1'b0;
				end	
			 else
				 begin
						if(stop == 1'b1) // When stopwatch is stopped
							begin
								ring <= 1'b1; // Ring
								// Counters reset automatically while ringing when stopped
								sec <= 7'd0;
								min <= 7'd0;
								hour <= 5'd0;
							end
						else // When stopwatch is running
							begin
								ring <= 1'b0; // Stop ringing
								// Assign current registers from the pre-calculated next values
								sec <= sec_calculated_next;
								min <= min_calculated_next;
								hour <= hour_calculated_next;
							end
				end
		end
		
		// Snapshot logic for recorded time
		always @ (posedge record or posedge reset) // Asynchronous reset for recorded values
		begin
			if(reset == 1'b1)
			begin
				rec_sec <= 7'd0;
				rec_min <= 7'd0;
				rec_hour <= 5'd0;
			end
			else
				begin
					rec_sec <= sec;
					rec_min <= min;
					rec_hour <= hour;
				end
		end
endmodule

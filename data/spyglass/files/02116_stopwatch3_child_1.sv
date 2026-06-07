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
	 
	 always @ (posedge clk or posedge reset)
		begin
			 if (reset == 1'b1)
				begin
					sec <= 7'd0;
					min <= 7'd0;
					hour <= 5'd0;
					ring <= 1'b0;
				end	
			 else
				 begin
						if(stop == 1'b1) // When stopped
							begin
								ring <= 1'b1; // Ring
								// Counters reset automatically while ringing when stopped
								sec <= 7'd0;
								min <= 7'd0;
								hour <= 5'd0;
							end
						else // When running
							begin
								ring <= 1'b0; // Stop ringing

								if (sec == 7'd59) begin // Seconds count 0-59
									sec <= 7'd0;
									if (min == 7'd59) begin // Minutes count 0-59
										min <= 7'd0;
										if (hour == 5'd12) begin // Hours count 0-12 (13 states)
											hour <= 5'd0;
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
		
		// Snapshot logic for recorded time
		always @ (posedge record or posedge reset) // Added reset to sensitivity list
		begin
			if(reset == 1'b1) // Asynchronous reset for recorded values
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

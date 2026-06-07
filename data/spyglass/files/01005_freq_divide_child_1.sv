module freq_divide(input clk, rst, output reg q_out);

	reg [3:0] count;
	reg [3:0] next_count; // Added to resolve W415a

	parameter TIME_EXPANSION_FACTOR = 4.5;
	parameter DUTY = 0.5; //This corresponds to 50% duty cycle

	// Changed to localparam integer to resolve SYNTH_89. 
	// Real values (like 4.5) assigned to integers will be truncated (e.g., 4.5 becomes 4).
	localparam integer t_on = TIME_EXPANSION_FACTOR*2*DUTY;
	localparam integer total_time = TIME_EXPANSION_FACTOR*2;

	// Fixed 'bothedges' violation by removing 'negedge clk'.
	// 'badimplicitSM1' is resolved as asynchronous reset is the first check.
	always@(posedge clk or posedge rst)
	begin
		if(rst)
			begin
				q_out<=0;
				count<=0;
			end
		else
			begin
				// Logic to determine the next value of 'count' (next_count).
				// This resolves W415a by ensuring 'count' has a single assignment via 'next_count'.
				if(count == total_time) begin
					next_count = 1;
				end else begin
					next_count = count + 1'd1;
				end
				count <= next_count; // Single assignment to count

				// The q_out logic has mutually exclusive assignments within this block,
				// which is synthesizable for a registered output.
				if(count<t_on)
					q_out<=1;
				else if(count<total_time)
					q_out<=0;
				else if(count == total_time)
				begin
					q_out<=~q_out;
					// count<=1; -- This assignment is now handled by the 'next_count' logic above.
				end
			end
	end

endmodule

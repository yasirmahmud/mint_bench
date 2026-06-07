module freq_divide(input clk, rst, output reg q_out);

	reg [3:0] count;
	reg [3:0] next_count; // Used for combinational next_state logic of 'count'
	reg next_q_out; // Added for combinational next_output logic of 'q_out'

	parameter TIME_EXPANSION_FACTOR = 4.5;
	parameter DUTY = 0.5; //This corresponds to 50% duty cycle

	// Changed to localparam integer to resolve SYNTH_89. 
	// Real values (like 4.5) assigned to integers will be truncated (e.g., 4.5 becomes 4).
	localparam integer t_on = TIME_EXPANSION_FACTOR*2*DUTY; // will be 4
	localparam integer total_time = TIME_EXPANSION_FACTOR*2; // will be 9

    // Combinational logic for calculating next state (next_count) and next output (next_q_out)
    // This resolves STARC05-2.11.3.1 by separating combinational logic from sequential updates.
    always @(*) begin
        // Logic to determine the next value of 'count' (next_count).
        if (count == total_time) begin
            next_count = 1;
        end else begin
            next_count = count + 1'd1;
        end

        // Logic to determine the next value of 'q_out' (next_q_out).
        // Based on current 'count' and 'q_out' values.
        if (count < t_on) begin
            next_q_out = 1;
        end else if (count < total_time) begin
            next_q_out = 0;
        end else if (count == total_time) begin
            next_q_out = ~q_out;
        end
    end

	// Sequential logic for state and output registers.
	// This updates 'count' and 'q_out' on the clock edge or reset.
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
				q_out<=0;
				count<=0;
		end
		else begin
				count <= next_count; // Update count with its combinational next state
				q_out <= next_q_out; // Update q_out with its combinational next output
		end
	end

endmodule

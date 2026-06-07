module freq_divide(input clk, rst, output reg q_out);

	reg [3:0] count;

	parameter TIME_EXPANSION_FACTOR = 4.5;
	parameter DUTY = 0.5; //This corresponds to 50% duty cycle

	integer t_on = TIME_EXPANSION_FACTOR*2*DUTY;
	// real t_off = TIME_EXPANSION_FACTOR*2*(1-DUTY);
	integer total_time = TIME_EXPANSION_FACTOR*2;

	always@(posedge clk or negedge clk)
	begin
		if(rst)
			begin
				q_out<=0;
				count<=0;
			end
		else
		begin
			count<=count+1'd1;
			if(count<t_on)
				q_out<=1;
			else if(count<total_time)
				q_out<=0;
			else if(count == total_time)
			begin
				q_out<=~q_out;
				count<=1;
			end
		end
	end

endmodule

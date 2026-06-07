module user_defined_up_counter(clk, rst, count);

	input clk, rst;
	output reg [4:0] count;
	
	always @(posedge clk)
	begin
		if(rst)
			count <= 5'b01100;
		else begin
			if(count == 5'b11100)
				count <= 5'b01100;
			else
				count <= count + 1'b1;
		end
	end

endmodule

module Input_wrapper(input clk, rst, inReady, inAccept, output reg enA, enB);
	integer counter = 0;
	always @(posedge clk, posedge rst) begin
		if(rst) begin
			enA <= 1'b1;
			enB <= 1'b0;
			counter = 0;
		end
		else if(inReady & ~inAccept & ~counter) begin
			enA <= ~enA;
			enB <= ~enB;
			counter = 1;
		end
	end
	
endmodule

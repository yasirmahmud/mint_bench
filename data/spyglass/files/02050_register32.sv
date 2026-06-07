module register32(input [31:0] Parallel_in, input clk, rst, enable, output reg [31:0] parallel_out, input Ready, output reg Accepted);
	always @(posedge clk, posedge rst) begin
		if(rst) begin
			parallel_out <= 32'd0;
			Accepted <= 0;
		end
		else if(Ready & enable) begin
			parallel_out <= Parallel_in;
			Accepted = 1;
		end
		else Accepted <= 0;
	end
endmodule

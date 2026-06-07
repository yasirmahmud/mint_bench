module register32out(input [31:0] Parallel_in, input clk, rst, enable, output reg [31:0] parallel_out);
	integer flag = 0;
	always @(posedge clk, posedge rst) begin
		if(rst) begin
			parallel_out <= 32'dz;
		end
		else if(enable) begin
			parallel_out <= Parallel_in;
		end
	end
endmodule

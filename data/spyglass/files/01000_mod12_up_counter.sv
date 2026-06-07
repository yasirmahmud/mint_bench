module mod12_up_counter(clk,rst,ld,data,count);

	//Defining the input and output ports
	input clk,rst,ld;
	input [3:0] data;
	output reg [3:0] count;
	
	//Logic for 4-bit synchronous mod-12 loadable up counter
	always @(posedge clk)
	begin
		if(rst)
		count <= 4'b0000;
		else if(ld)
		begin
			if(data > 4'b1011)
				count <= 4'b0000;
			else
				count <= data;
		end
		else if(count == 4'b1011)
		count <= 4'b0000;
		else
		count <= count+1'b1;
	end
	
endmodule

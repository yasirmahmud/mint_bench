module async_up_dn_counter(clk,rst,up_dn,count);
	
	//Defining the input and output ports
	input clk, rst, up_dn;
	output reg [3:0] count;
	
	//Logic for 4-bit binary up/down counter with asynchronous reset 
	always @(posedge clk or negedge rst)
	begin
		if(rst)
			count <= 4'b0000;
		else 
		begin
			if(up_dn)
				count <= count+1'b1;
			else
			 count <= count-1'b1;
		end
	end
	
endmodule

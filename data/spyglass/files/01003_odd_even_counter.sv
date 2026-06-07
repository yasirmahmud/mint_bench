module odd_even_counter(clk, rst, d_in, count_odd, count_even);

	//Declaring the input and output ports
	input clk, rst;
	input [3:0] d_in;
	output [3:0] count_odd, count_even;
	
	reg [3:0] odd_count, even_count;
	
	//Logic for Even and Odd counter
	always@(posedge clk or negedge rst)
	begin
		if(rst)
			{odd_count,even_count}=4'b0000;
		else 
		begin
			if(d_in%2==0)
				even_count <= even_count + 1'b1;
			else
				odd_count <= odd_count + 1'b1;
		end
	end
	
	assign count_odd = odd_count;
	assign count_even = even_count;

endmodule

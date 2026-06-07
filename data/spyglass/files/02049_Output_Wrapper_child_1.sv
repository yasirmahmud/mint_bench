module Output_Wrapper(input clk, rst, input [9:0] Resultexpfinal, input [22:0] product_mantissa, input Sign, doneMul,
			 output reg [31:0] ResultBus, input resultaccepted, output reg resultready, Operationdone, enR);
	
always @(posedge clk, posedge rst) begin
		if(rst) begin 
			resultready <= 0;
			Operationdone <= 0; // Fix: Changed to non-blocking assignment
			enR <= 0; // Fix: Added reset for enR to resolve STARC05 violation
		end
		else if(resultaccepted) begin
			resultready <= 0;
			Operationdone <= 1; // Fix: Changed from blocking to non-blocking assignment
		end
		else if(doneMul & ~Operationdone) begin
			enR <= 1; // Fix: Changed from blocking to non-blocking assignment
			resultready <= 1;
			ResultBus <= {Sign, Resultexpfinal[7:0], product_mantissa};
		end
		else resultready <= 0;
	end
endmodule

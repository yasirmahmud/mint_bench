module my_dff_en(
	input DFF_CLOCK, 
	input clock_enable, 
	input D, 
	output reg Q=0
);

    always @ (posedge DFF_CLOCK) 
	begin
		if(clock_enable==1) 
			Q <= D;
    end
	
endmodule

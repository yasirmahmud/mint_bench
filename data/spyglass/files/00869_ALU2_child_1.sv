module ALU2  (A, B, S, Ai, Bi, Ar, Br, clk, So, sub);

	input [7:0]A;
	input [7:0]B;
	input Ai, Bi, Ar, Br, clk, So, sub;
	output [7:0]S;
	// Removed wire Ao, Bo; as they were unused and caused W528 violations
	reg[7:0]At;
	reg[7:0]Bt;
	reg[7:0]St;
	
	// Changed always@(clk) to always @(posedge clk) to resolve W122 (sensitivity list) 
	// and InferLatch violations by explicitly defining synchronous, edge-triggered logic.
	always @(posedge clk) begin
		if(Ai==1'b1) At <= A;
		else if(Ar==1'b1) At <= 8'b00000000;
		// If neither Ai nor Ar is active, At retains its value, which is standard flip-flop behavior.
	end
	
	// Changed always@(clk) to always @(posedge clk) to resolve W122 (sensitivity list) 
	// and InferLatch violations by explicitly defining synchronous, edge-triggered logic.
	always @(posedge clk) begin
		if(Bi==1'b1) Bt <= B;
		else if(Br==1'b1) Bt <= 8'b00000000;
		// If neither Bi nor Br is active, Bt retains its value, which is standard flip-flop behavior.
	end
	
	// Changed always@(clk) to always @(posedge clk) to resolve W122 (sensitivity list) violations.
	always @(posedge clk) begin
		if(sub==1'b1) St <= A-B;
		else St <= A+B;
	end
	
	// Removed assign Ao = At; // Fixes W528 variable 'Ao' set but not read.
	// Removed assign Bo = Bt; // Fixes W528 variable 'Bo' set but not read.
	
	assign S = (So==1'b1) ? St
					: 8'b00000000;
endmodule

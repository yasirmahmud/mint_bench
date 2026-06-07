module priority_encoder_generic #(parameter n = 4) (
input [n-1:0]w,
output reg [$clog2(n)-1:0]y,
output z
);

// Moving 'reg found_one' declaration to module level to resolve STX_VE_479 violation.
reg found_one;

assign z = |w;

integer i;

always @* // Changed to @* for explicit combinational logic
begin
	found_one = 1'b0;
	y = 0;          // Default value for y (resolves NoAssignX-ML violation)

	// Iterate from the highest index down to 0.
	// The first '1' encountered corresponds to the highest priority index.
	// We assign y once and then use 'found_one' to prevent further assignments
	// within the loop, resolving the W415a violation.
	for(i = n - 1; i >= 0; i = i - 1) begin
		if(w[i] && !found_one) begin
			y = i;
			found_one = 1'b1;
		end
	end
end
endmodule

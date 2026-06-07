module CLKGATETST_X1 (
	CK,
	E,
	SE,
	GCK
);
	input CK;
	input E;
	input SE;
	output GCK;

	reg q_latch;

	// Transparent D-latch: latches E when CK is low
	// The enable signal 'E' is sampled and held by a latch, usually when the clock is low.
	// This ensures a stable enable signal when the clock transitions high.
	always @(E or CK) begin
		if (~CK) begin // Latch is transparent when clock (CK) is low
			q_latch = E;
		end
		// else (CK is high), q_latch holds its previous value
	end

	// Gated clock generation logic:
	// If SE (Test Enable) is high, the clock is passed directly (bypass enable 'E').
	// If SE is low, the clock is gated by the latched enable 'q_latch'.
	// The output GCK is CK ANDed with (SE OR q_latch).
	// This effectively means: GCK = CK when (SE or q_latch) is high.
	assign GCK = CK & (SE | q_latch);

endmodule // CLKGATETST_X1

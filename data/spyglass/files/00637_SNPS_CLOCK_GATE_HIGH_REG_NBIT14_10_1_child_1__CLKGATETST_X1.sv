module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

reg latch_out;

// Latch behavior: captures E when CK is low, holds when CK is high
always @(CK or E) begin
    if (!CK) begin // when CK is low
        latch_out = E;
    end
end

// Gated clock generation:
// In test mode (SE high), bypass the clock gate.
// Otherwise, the clock is gated by the latched enable signal.
assign GCK = SE ? CK : (CK & latch_out);

endmodule

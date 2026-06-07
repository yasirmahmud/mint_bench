module scrambler_lfsr(
    input [7:0] challenge,
    output reg [7:0] scrambler_out, // Changed to reg to allow sequential assignment
    input clock,
    input reset,
    input scrambler_reset
    );
    // Implemented a minimal LFSR-like behavior to consume all inputs
    always @(posedge clock or posedge reset or posedge scrambler_reset) begin
        if (reset || scrambler_reset) begin
            scrambler_out <= challenge; // Initialize with challenge or 0
        end else begin
            // Example LFSR-like behavior using challenge for feedback
            scrambler_out <= {scrambler_out[6:0], scrambler_out[7] ^ challenge[0]};
        end
    end
endmodule

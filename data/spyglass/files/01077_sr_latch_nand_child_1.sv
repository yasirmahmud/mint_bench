module sr_latch_nand(s,r,q,q_bar);
input s,r;
output reg q,q_bar;

always @* begin
    // S, R are active-low inputs for a NAND latch
    if (s == 1'b0 && r == 1'b0) begin
        // Invalid state: both Q and Q_bar go high, consistent with NAND gate implementation
        q     = 1'b1;
        q_bar = 1'b1;
    end else if (s == 1'b0) begin
        // Set state: S is active-low (0), R is high (1)
        q     = 1'b1;
        q_bar = 1'b0;
    end else if (r == 1'b0) begin
        // Reset state: R is active-low (0), S is high (1)
        q     = 1'b0;
        q_bar = 1'b1;
    end
    // else (s == 1'b1 && r == 1'b1): Hold state. No explicit assignment implies the latch holds its current value.
end

endmodule

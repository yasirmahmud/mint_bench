module SR_flipflop(
    input clk, reset, S, R,
    output reg Q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            // S=1, R=1 is considered an invalid state in a standard SR latch/flip-flop.
            // However, based on the usage (S = T & ~Q_sr, R = T & Q_sr),
            // S and R can never be simultaneously high (T=1 leads to S=~Q_sr, R=Q_sr, so one is high, the other low).
            // Also, when T=0, S=0, R=0, which means Q holds.
            // This implementation covers the valid states (Set, Reset, Hold) that occur from the parent module's logic.
            if (S == 1'b1 && R == 1'b0) begin
                Q <= 1'b1; // Set
            end else if (S == 1'b0 && R == 1'b1) begin
                Q <= 1'b0; // Reset
            end
            // else (S=0, R=0) Q holds implicitly
        end
    end
endmodule

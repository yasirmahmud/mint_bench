module t_to_jk_flipflop (
    input j, k,     // Inputs for JK Flip-Flop
    input clk,      // Clock signal
    input reset,    // Reset signal
    output reg Q    // Output
);
    wire T;

    // Map T to JK inputs
    assign T = (j & ~Q) | (k & Q);

    // JK flip-flop with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;    // Reset the output to 0
        else begin
            case ({j, k})
                2'b00: Q <= Q;      // No change
                2'b01: Q <= 0;      // Reset
                2'b10: Q <= 1;      // Set
                2'b11: Q <= ~Q;     // Toggle
            endcase
        end
    end
endmodule

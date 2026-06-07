module sr_to_jk_flipflop (
    input wire clk,     // Clock signal
    input wire reset,   // Asynchronous reset
    input wire J,       // J input
    input wire K,       // K input
    output reg Q        // Output Q
);
    wire S, R;
    wire Qb;

    // Complement of Q
    assign Qb = ~Q;

    // Mapping J and K to S and R
    assign S = J & Qb;
    assign R = K & Q;

    // SR Flip-Flop logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; // Reset Q to 0
        end else begin
            case ({S, R})
                2'b00: Q <= Q;       // No change
                2'b01: Q <= 1'b0;    // Reset
                2'b10: Q <= 1'b1;    // Set
                2'b11: Q <= 1'bx;    // Invalid for SR Flip-Flop
            endcase
        end
    end
endmodule

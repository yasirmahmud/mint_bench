module sr_to_d_flipflop (
    input wire clk,     // Clock signal
    input wire reset,   // Asynchronous reset
    input wire D,       // Data input
    output reg Q        // Output Q
);
    wire S, R;

    // Generate S and R from D
    assign S = D;
    assign R = ~D;

    // D Flip-Flop logic, derived from SR behavior
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; // Reset output to 0
        end else begin
            // Since S = D and R = ~D, the SR flip-flop behavior simplifies to Q <= D.
            // If D=1, then S=1, R=0 (set Q to 1). If D=0, then S=0, R=1 (reset Q to 0).
            // This inherently resolves the unreachable 2'b11 case and the 'X' assignment.
            Q <= D;
        end
    end
endmodule

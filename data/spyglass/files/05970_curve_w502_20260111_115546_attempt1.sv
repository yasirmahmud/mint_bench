module curve_w502_20260111_115546_attempt1 (
    input wire en,
    input wire d_in,
    output reg q_out
);

    // This always block describes a level-sensitive latch.
    // The explicit self-assignment 'q_out = q_out' in the else branch
    // is intended to hold the value when 'en' is low.
    // SpyGlass W502 is triggered by this self-assignment, considering it a modification.
    always @(en or d_in or q_out) begin
        if (en) begin
            q_out = d_in;
        end else begin
            // This line specifically triggers W502
            q_out = q_out;
        end
    end

endmodule

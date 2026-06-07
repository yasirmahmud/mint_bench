module curve_synth_5059_20260112_000730_661766_w25608_attempt15 (
    input [7:0] data_a,
    input [7:0] data_b,
    output reg match_flag
);

    // Trigger SYNTH_5059: Case inequality (!==) which is not supported by synthesis.
    // The '!'== operator is used within an 'if' condition inside a combinational always block.
    // This example compares two multi-bit input signals, avoiding 'x' or 'z' literals.
    always @* begin
        match_flag = 1'b0; // Default assignment to avoid latches
        if (data_a !== data_b) begin
            match_flag = 1'b1;
        end
    end

endmodule

module curve_w339a_20260111_185304_096466_w53504_attempt6 (
    input [1:0] a,
    input [1:0] b,
    output reg out
);

    // W339a: Operator '!==' should be avoided in synthesis logic
    // The case inequality operator ('!==') compares operands bit-by-bit,
    // treating X and Z values as significant. Synthesis tools typically
    // flag this operator because X/Z states are primarily simulation
    // constructs and their explicit comparison can lead to ambiguous
    // or non-synthesizable hardware behavior.
    always @* begin
        if (a !== b) begin // This use of '!==' triggers W339a
            out = 1'b1;
        end else begin
            out = 1'b0;
        end
    end

endmodule

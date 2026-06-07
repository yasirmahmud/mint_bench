module w310_ex2 (
    input clk,
    input rst,
    output reg [7:0] unsigned_reg
);

    // The original 'initial' block assigned signed_int = -10, then unsigned_reg = signed_int.
    // For a 32-bit integer, -10 is 0xFFFFFFF6. Truncated to an 8-bit unsigned reg, this becomes 8'hF6.
    // To resolve SYNTH_5143 (initial block ignored for synthesis) and W528 (variable set but not read),
    // the assignment is moved to a synthesizable always block with a reset.
    // 'unsigned_reg' is also declared as an output to resolve W528.

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            unsigned_reg <= 8'hF6;
        end
        // No other logic is added as the original 'unsigned_reg' was only assigned once
        // and held its value afterwards.
    end

endmodule

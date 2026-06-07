module curve_w442a_20260111_194906_276303_w37940_attempt6 (
    input clk,
    input rst_n,
    output reg q
);

// This 'always' block implements an asynchronously reset flip-flop.
// The rule W442a "Asynchronously reset/set always block has missing 'if' statement at the top level"
// is triggered here because, despite having an 'if' statement for the asynchronous reset at the top level,
// it lacks an 'else' branch to explicitly define the synchronous behavior.
// This structure directly matches the provided context example 1, which also triggers W442a.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= 1'b0;
    end
    // Missing 'else' branch for synchronous logic is the assumed cause of the violation.
end

endmodule

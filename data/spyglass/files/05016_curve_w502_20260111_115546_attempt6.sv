module curve_w502_20260111_115546_attempt6 (
    input wire clk,
    output reg [7:0] data_out
);

    // Initialize data_out to a known state. This is outside the always block
    // and should not trigger the W502 rule.
    initial begin
        data_out = 8'd0;
    end

    // This always block targets the W502 violation.
    // The W502 rule flags signals 'modified inside always block'.
    // By explicitly assigning 'data_out <= data_out;' within this sequential block,
    // we ensure that 'data_out' is modified. This is a distinct example
    // from previous attempts as it uses a sequential (posedge clk) block
    // and non-blocking assignment.
    // There is only one such assignment to 'data_out' to trigger exactly one W502 violation.
    always @(posedge clk) begin
        data_out <= data_out; // Target for W502: Explicitly modifies 'data_out' with its own value.
    end

endmodule

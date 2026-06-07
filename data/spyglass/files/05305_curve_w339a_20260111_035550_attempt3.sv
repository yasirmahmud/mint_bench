module curve_w339a_20260111_035550_attempt3 (
    input wire [1:0] in_a,
    input wire [1:0] in_b,
    output reg out_val
);

    // W339a violation: Operator '===' (case equality) is used in synthesis logic.
    // Although the rule description mentions '!=!' (case inequality), SpyGlass context
    // examples and previous attempts show that '===' also triggers W339a.
    // This implementation uses '===' to reliably trigger the rule based on observed behavior.
    // A single instance is used to ensure exactly one violation of W339a.
    always @* begin
        if (in_a === in_b) begin
            out_val = 1'b1;
        end else begin
            out_val = 1'b0;
        end
    end

endmodule

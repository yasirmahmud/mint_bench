module curve_starc05_2_10_1_4b_20260111_192915_401214_w47100_attempt10 (
    input wire [2:0] data_in,
    output reg        dummy_out
);

    // STARC05-2.10.1.4b violation: A signal (data_in) is compared with a value containing 'x' (3'b10x).
    // This example aims to trigger STARC05-2.10.1.4b without triggering STARC05-2.10.1.4a,
    // as 3'b10x contains 'x' but is not entirely 'x'.
    // The comparison is placed in an always block to make it synthesizable and use all ports,
    // minimizing other common warnings like W240, W541, SYNTH_5143.
    // However, W339a (Operator '===' should be avoided in synthesis logic) is a common
    // side-effect warning when using case equality in synthesizable code, as seen in context examples.
    always @(*) begin
        if (data_in === 3'b10x) begin // Target violation line
            dummy_out = 1'b1;
        end else begin
            dummy_out = 1'b0;
        end
    end

endmodule

module curve_starc05_2_10_1_4b_20260111_192915_401214_w47100_attempt9 (
    input wire [0:0] dummy_in,
    output reg        dummy_out
);

    initial begin
        // STARC05-2.10.1.4b violation: A signal (dummy_in) is compared with a value containing 'x' (1'bX).
        // This statement is placed within an initial block and a $display construct
        // to minimize the likelihood of triggering synthesis-related warnings (e.g., SYNTH_5058, W339a),
        // as these constructs are typically ignored by synthesis tools for functional logic.
        $display("Debug: Comparison result %b", (dummy_in === 1'bX));
    end

    // Minimal synthesizable logic to ensure the module is valid
    // and all ports are used, without introducing other violations.
    always @(*) begin
        dummy_out = 1'b0;
    end

endmodule

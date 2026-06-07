module curve_w218_20260111_071226_attempt8 (
    input [1:0] multibit_sig, // Multibit signal to trigger W218
    output reg  output_data
);

    // W218 trigger: Edge specification should not be used for a multibit expression.
    // The 'posedge' keyword is applied to 'multibit_sig', which is a 2-bit expression,
    // within an 'always' block's sensitivity list. This is the canonical way
    // to trigger W218 as indicated by the rule description and context examples.
    always @(posedge multibit_sig) begin // This line targets W218
        output_data <= multibit_sig[0]; // Simple assignment to use the multibit_sig and drive an output
    end

endmodule

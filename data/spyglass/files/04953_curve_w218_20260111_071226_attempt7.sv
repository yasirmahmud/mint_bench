module curve_w218_20260111_071226_attempt7 (
    input [1:0] multibit_sig, // Multibit signal to trigger W218
    input       clk,          // Standard clock for synthesizable logic
    input       reset,
    input       enable_in,
    output reg  output_data
);

    // W218 trigger: Edge specification should not be used for a multibit expression.
    // This 'initial' block uses 'posedge' on a multibit signal 'multibit_sig'
    // in a 'wait' statement. 'initial' blocks are generally ignored by synthesis,
    // which helps prevent SYNTH_5405 (multibit signal used as a clock),
    // but the language rule W218 should still apply as it's a semantic check.
    initial begin
        $display("Initial block active.");
        wait (posedge multibit_sig); // This line targets W218
        $display("W218 trigger: Multibit edge detected on multibit_sig = %b", multibit_sig);
    end

    // A minimal synthesizable block to ensure the module is considered by synthesis tools
    // and to avoid other general synthesis errors (e.g., ErrorAnalyzeBBox for unsynthesizable DU).
    // This block is designed not to cause any additional violations.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            output_data <= 1'b0;
        end else if (enable_in) begin
            output_data <= ~output_data; // Toggle output_data on enable
        end
    end

endmodule

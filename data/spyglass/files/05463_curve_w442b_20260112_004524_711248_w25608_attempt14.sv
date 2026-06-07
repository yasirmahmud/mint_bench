module curve_w442b_20260112_004524_711248_w25608_attempt14 (
    input clk,
    input reset_n_sig, // Asynchronous active-low reset signal
    input control_val_a, // Non-constant expression for comparison A
    input control_val_b, // Non-constant expression for comparison B
    output reg output_q_a,
    output reg output_q_b
);

    // W442b violation 1: In asynchronous reset always block, 'reset_n_sig' is compared to non-constant 'control_val_a'
    always @(posedge clk or negedge reset_n_sig) begin
        if (reset_n_sig == control_val_a) begin // Violation: Comparison with non-constant 'control_val_a'
            output_q_a <= 1'b0; // Asynchronous reset condition
        end else begin
            output_q_a <= control_val_a;
        end
    end

    // W442b violation 2: In asynchronous reset always block, 'reset_n_sig' is compared to non-constant 'control_val_b'
    always @(posedge clk or negedge reset_n_sig) begin
        if (reset_n_sig == control_val_b) begin // Violation: Comparison with non-constant 'control_val_b'
            output_q_b <= 1'b0; // Asynchronous reset condition
        end else begin
            output_q_b <= control_val_b;
        end
    end

endmodule

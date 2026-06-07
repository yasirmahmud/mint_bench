module curve_w442b_20260112_004524_711248_w25608_attempt15 (
    input clk,
    input rst_async_p, // Asynchronous active-high reset signal
    input control_cond_a, // Non-constant expression for comparison 1
    input control_cond_b, // Non-constant expression for comparison 2
    output reg q_a,
    output reg q_b
);

    // W442b violation 1: 'rst_async_p' is compared to non-constant 'control_cond_a'
    // in an asynchronous reset always block.
    always @(posedge clk or posedge rst_async_p) begin
        if (rst_async_p == control_cond_a) begin // Violation: Comparison with non-constant 'control_cond_a'
            q_a <= 1'b0; // Asynchronous reset condition
        end else begin
            q_a <= control_cond_a; // Use to avoid unused signal warning
        end
    end

    // W442b violation 2: 'rst_async_p' is compared to non-constant 'control_cond_b'
    // in an asynchronous reset always block.
    always @(posedge clk or posedge rst_async_p) begin
        if (rst_async_p == control_cond_b) begin // Violation: Comparison with non-constant 'control_cond_b'
            q_b <= 1'b0; // Asynchronous reset condition
        end else begin
            q_b <= control_cond_b; // Use to avoid unused signal warning
        end
    end

endmodule

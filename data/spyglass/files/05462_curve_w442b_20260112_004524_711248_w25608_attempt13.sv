module curve_w442b_20260112_004524_711248_w25608_attempt13 (
    input clk,
    input rst_async, // Asynchronous reset signal
    input data_in_a, // Non-constant expression for comparison A
    input data_in_b, // Non-constant expression for comparison B
    output reg q_out_a,
    output reg q_out_b
);

    // W442b violation 1: In asynchronous reset always block, 'rst_async' is compared to non-constant 'data_in_a'
    always @(posedge clk or posedge rst_async) begin
        if (rst_async == data_in_a) begin // Violation: Comparison with non-constant 'data_in_a'
            q_out_a <= 1'b0;
        end else begin
            q_out_a <= 1'b1;
        end
    end

    // W442b violation 2: In asynchronous reset always block, 'rst_async' is compared to non-constant 'data_in_b'
    always @(posedge clk or posedge rst_async) begin
        if (rst_async == data_in_b) begin // Violation: Comparison with non-constant 'data_in_b'
            q_out_b <= 1'b0;
        end else begin
            q_out_b <= 1'b1;
        end
    end

endmodule

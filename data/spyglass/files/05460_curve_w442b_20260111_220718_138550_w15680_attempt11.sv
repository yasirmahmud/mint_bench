module curve_w442b_20260111_220718_138550_w15680_attempt11 (
    input clk,
    input rst_n,        // Asynchronous active-low reset
    input data_in_a,    // Non-constant expression for first violation
    input data_in_b,    // Non-constant expression for second violation
    output reg q_out_a,
    output reg q_out_b
);

    // Violation 1: In this asynchronous reset block, the reset signal 'rst_n'
    // is compared to 'data_in_a', which is a non-constant expression.
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == data_in_a) begin // W442b violation: comparison with non-constant 'data_in_a'
            q_out_a <= 1'b0; // Asynchronous reset condition
        end else begin
            q_out_a <= data_in_a; // Sequential logic, also ensures data_in_a is used
        end
    end

    // Violation 2: In this asynchronous reset block, the reset signal 'rst_n'
    // is compared to 'data_in_b', which is a non-constant expression.
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == data_in_b) begin // W442b violation: comparison with non-constant 'data_in_b'
            q_out_b <= 1'b0; // Asynchronous reset condition
        end else begin
            q_out_b <= data_in_b; // Sequential logic, also ensures data_in_b is used
        end
    end

endmodule

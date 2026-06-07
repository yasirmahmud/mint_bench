module curve_w442b_20260111_220718_138550_w15680_attempt12 (
    input clk,
    input rst_p, // Active-high asynchronous reset
    input condition_a, // Non-constant expression for first violation
    input condition_b, // Non-constant expression for second violation
    output reg out_reg_a,
    output reg out_reg_b
);

    // Violation 1: In this asynchronous reset block, the active-high reset signal 'rst_p'
    // is compared to 'condition_a', which is a non-constant expression.
    always @(posedge clk or posedge rst_p) begin
        if (rst_p == condition_a) begin // W442b violation expected here
            out_reg_a <= 1'b0; // Asynchronous reset condition
        end else begin
            out_reg_a <= condition_a; // Ensures 'condition_a' is used to avoid unused signal warning
        end
    end

    // Violation 2: In this asynchronous reset block, the active-high reset signal 'rst_p'
    // is compared to 'condition_b', which is a non-constant expression.
    always @(posedge clk or posedge rst_p) begin
        if (rst_p == condition_b) begin // W442b violation expected here
            out_reg_b <= 1'b0; // Asynchronous reset condition
        end else begin
            out_reg_b <= condition_b; // Ensures 'condition_b' is used to avoid unused signal warning
        end
    end

endmodule

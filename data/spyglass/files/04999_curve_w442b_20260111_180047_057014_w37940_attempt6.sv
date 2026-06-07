module curve_w442b_20260111_180047_057014_w37940_attempt6 (
    input clk,
    input rst_n,
    input enable_in,
    input data_in,
    output reg q1,
    output reg q2
);

    always @(posedge clk or negedge rst_n) begin
        // Violation 1: In asynchronous reset block, comparison to non-constant 'enable_in'
        if (rst_n == enable_in) begin
            q1 <= 1'b0;
        end else begin
            q1 <= ~q1;
        end

        // Violation 2: In asynchronous reset block, comparison to non-constant 'data_in'
        if (rst_n == data_in) begin
            q2 <= 1'b1;
        end else begin
            q2 <= enable_in;
        end
    end

endmodule

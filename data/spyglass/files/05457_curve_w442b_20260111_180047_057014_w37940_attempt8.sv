module curve_w442b_20260111_180047_057014_w37940_attempt8 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input data_input_val_a,
    input data_input_val_b,
    output reg q_output_a,
    output reg q_output_b
);

    // W442b violation #1: In asynchronous reset always block, a comparison is made to a
    // non-constant expression (data_input_val_a) in the reset condition.
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == data_input_val_a) begin // Comparison to non-constant expression
            q_output_a <= 1'b0;
        end else begin
            q_output_a <= data_input_val_a;
        end
    end

    // W442b violation #2: This separate asynchronous reset block also contains a comparison
    // to a non-constant expression (data_input_val_b) in its reset condition,
    // leading to a second occurrence of the violation.
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == data_input_val_b) begin // Comparison to non-constant expression
            q_output_b <= 1'b0;
        end else begin
            q_output_b <= data_input_val_b;
        end
    end

endmodule

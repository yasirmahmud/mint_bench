module curve_w442b_20260111_180047_057014_w37940_attempt10 (
    input clk,
    input arst_n, // Active-low asynchronous reset
    input control_data, // Non-constant expression for comparison in reset condition
    input data_in,
    output reg q_out
);

    // W442b violation: In an asynchronous reset/set always block, comparison is being made to a non-constant expression (control_data)
    always @(posedge clk or negedge arst_n) begin
        if (!arst_n) begin // Fixed: Changed 'arst_n == control_data' to '!arst_n' for active-low asynchronous reset
            q_out <= 1'b0; // Asynchronous reset condition
        end else begin
            q_out <= data_in; // Synchronous data path
        end
    end

endmodule

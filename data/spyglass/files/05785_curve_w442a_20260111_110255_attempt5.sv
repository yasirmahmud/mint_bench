module curve_w442a_20260111_110255_attempt5 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input condition, // Control signal for synchronous logic
    input data_in_a,
    input data_in_b,
    output reg data_out // Output register
);

reg internal_data_reg; // Internal register to hold data before output

// Asynchronously reset always block
always @(posedge clk or negedge rst_n) begin
    // W442a violation: This 'if' statement (controlling internal_data_reg)
    // is not the top-level asynchronous reset 'if' statement for this block.
    // Any statement before the top-level 'if (!rst_n)' triggers W442a.
    if (condition) begin
        internal_data_reg <= data_in_a;
    end else begin
        internal_data_reg <= data_in_b;
    end

    // The asynchronous reset 'if' statement is not the first top-level statement.
    if (!rst_n) begin // Asynchronous reset path
        data_out <= 1'b0; // Reset output to 0
    end else begin // Synchronous path
        data_out <= internal_data_reg; // Use internal_data_reg to avoid W528 (unused signal)
    end
end

endmodule

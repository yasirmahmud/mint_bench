module curve_w442a_20260111_110255_attempt4 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input d_in,
    output reg q_out // Output register
);

reg bad_reg; // Register to trigger W442a

// Asynchronously reset always block
always @(posedge clk or negedge rst_n) begin
    // W442a violation: Assignment to 'bad_reg' occurs before the
    // top-level 'if (!rst_n)' statement.
    // This ensures 'W442a' is triggered.
    bad_reg <= d_in; 

    // The asynchronous reset 'if' statement is not the first top-level statement.
    if (!rst_n) begin // Asynchronous reset path
        q_out <= 1'b0; // q_out is correctly reset
    end else begin // Synchronous path
        q_out <= bad_reg; // Use bad_reg to avoid W528 (unused signal)
    end
end

endmodule

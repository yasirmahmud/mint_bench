module curve_w442a_20260111_110255_attempt3 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input d_in,
    output reg q_out
);

reg temp_reg; // Internal register, will be reset asynchronously and used

always @(posedge clk or negedge rst_n) begin
    // W442a violation: This statement assigns to 'temp_reg'.
    // It is placed *before* the top-level 'if (!rst_n)' check.
    // An asynchronously reset always block requires its reset 'if' statement
    // to be the very first top-level statement in the block.
    temp_reg <= d_in; 
    
    if (!rst_n) begin // Asynchronous reset path for both registers
        q_out <= 1'b0;
        temp_reg <= 1'b0; 
    end else begin // Synchronous path
        q_out <= temp_reg; // 'temp_reg' is used here to avoid W528 (unused signal)
    end
end

endmodule

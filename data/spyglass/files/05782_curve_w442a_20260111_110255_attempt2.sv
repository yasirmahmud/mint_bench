module curve_w442a_20260111_110255_attempt2 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input d_in,
    output reg q_out
);

reg dummy_reg; // Internal register to cause the W442a violation distinctly

always @(posedge clk or negedge rst_n) begin
    // W442a violation: This assignment is at the top level of the always block
    // and occurs BEFORE the asynchronous reset 'if' statement for q_out.
    // The rule W442a requires the 'if' statement for asynchronous reset
    // to be the very first top-level statement in the always block.
    dummy_reg <= 1'b0; 
    
    if (!rst_n) begin // Asynchronous reset for q_out
        q_out <= 1'b0; 
    end else begin
        q_out <= d_in; // Synchronous data path for q_out
    end
end

endmodule

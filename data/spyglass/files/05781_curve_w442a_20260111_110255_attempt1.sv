module curve_w442a_20260111_110255_attempt1 (
    input clk,
    input rst_n, // Active low asynchronous reset
    input d_in,
    output reg q_out
);

always @(posedge clk or negedge rst_n) begin
    // W442a violation: This assignment is at the top level of the always block
    // and occurs BEFORE the asynchronous reset 'if' statement. 
    // The rule requires the 'if' statement for asynchronous reset to be the 
    // very first top-level statement in the block.
    q_out <= d_in; 
    
    if (!rst_n) begin
        q_out <= 1'b0; // Asynchronous reset action
    end
    // No 'else' block is included to keep the example minimal and focused
    // solely on the W442a violation caused by the preceding assignment.
end

endmodule

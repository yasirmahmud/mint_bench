module blocking_flop_1 (
    input clk,
    input rst_n,
    input d_in,
    output reg q_out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q_out = 1'b0; // Blocking assignment for reset
    end else begin
        q_out = d_in; // Violation: Blocking assignment to a flip-flop output
    end
end

endmodule

module curve_starc05_2_11_3_1_20260111_141940_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire enable_i,
    output reg out_o
);

parameter S_IDLE = 1'b0;
parameter S_ACTIVE = 1'b1;

reg current_state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= S_IDLE;
        out_o <= 1'b0;
    end else begin
        // The combinational logic to determine the next state based on current_state
        // and enable_i is described directly within this sequential always block,
        // along with the non-blocking assignments to update current_state.
        // This mixing of combinational (next state logic) and sequential (state update)
        // parts of an FSM in the same clocked block triggers STARC05-2.11.3.1.
        if (current_state == S_IDLE) begin
            if (enable_i) begin
                current_state <= S_ACTIVE;
                out_o <= 1'b0;
            end else begin
                current_state <= S_IDLE;
                out_o <= 1'b0;
            end
        end else begin // current_state == S_ACTIVE
            current_state <= S_IDLE;
            out_o <= 1'b1;
        end
    end
end

endmodule

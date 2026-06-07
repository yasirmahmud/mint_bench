module curve_sim_race02_20260111_123109_attempt5 (
    input clk,
    input rst_n,
    input enable_idx_a,
    input enable_idx_b,
    input [0:0] idx_a,
    input [0:0] idx_b,
    input [7:0] data_a,
    input [7:0] data_b,
    output reg [7:0] acc_buff_r0 [1:0]
);

    // This module aims to trigger exactly one sim_race02 violation without W415.
    // It creates a situation where two conditional non-blocking assignments
    // to potentially the same element of an array of registers can occur
    // at the same clock edge, leading to a write-write race in simulation.
    // Synthesis tools might not flag this as a hard W415 (multiple drivers)
    // if the driving logic is within a single always block or structurally distinct.
    // However, static analysis tools like SpyGlass are expected to detect the
    // potential ambiguity when idx_a == idx_b and both enables are active.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0[0] <= 8'h00;
            acc_buff_r0[1] <= 8'h00;
        end else begin
            // Assignment 1 to an indexed element of acc_buff_r0
            if (enable_idx_a) begin
                acc_buff_r0[idx_a] <= data_a;
            end

            // Assignment 2 to an indexed element of acc_buff_r0
            // This assignment will create a write-write race with Assignment 1
            // if enable_idx_a, enable_idx_b are both high AND idx_a == idx_b
            // at the same positive clock edge.
            if (enable_idx_b) begin
                acc_buff_r0[idx_b] <= data_b;
            end
        end
    end

endmodule

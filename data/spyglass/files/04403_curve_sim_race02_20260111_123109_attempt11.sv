module curve_sim_race02_20260111_123109_attempt11 (
    input clk,
    input rst_n,
    input enable_cond1,
    input enable_cond2,
    input enable_override,
    input [7:0] data_val1,
    input [7:0] data_val2,
    input [7:0] data_override,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // conditional non-blocking assignments to it within a single
    // 'always @(posedge clk)' block, where the conditions can overlap.
    //
    // Distinct from previous attempts:
    // Attempt 10 used two independent 'if' statements. This attempt uses
    // a primary 'if-else if' structure for two conditions, and then a
    // separate, independent 'if' statement which can conflict with the
    // assignments made by the primary structure.
    //
    // If 'enable_cond1' is true, and 'enable_override' is also true,
    // 'acc_buff_r0' receives non-blocking assignments from both paths
    // ('data_val1' and 'data_override') at the same clock edge.
    // Similarly, if 'enable_cond1' is false, but 'enable_cond2' is true,
    // AND 'enable_override' is also true, 'acc_buff_r0' would race between
    // 'data_val2' and 'data_override'.
    // In both scenarios, the final value of 'acc_buff_r0' at the end of
    // the simulation time step is indeterminate, leading to a simulation race.
    //
    // The primary goal is to ensure SpyGlass reports 'sim_race02' for this
    // scenario, distinguishing it from generic multiple assignment warnings
    // (like W415a or STARC05-2.2.3.3) which often occur for similar code patterns.
    //
    // This design avoids implicit nets, mismatched widths, and latches.
    // All inputs and outputs are used.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'd0; // Reset condition
        end else begin
            // Primary conditional assignment block
            if (enable_cond1) begin
                acc_buff_r0 <= data_val1;
            end else if (enable_cond2) begin // Mutually exclusive with enable_cond1
                acc_buff_r0 <= data_val2;
            end
            // This independent 'if' statement can cause a race with the above block
            // if 'enable_override' is true concurrently with 'enable_cond1' or 'enable_cond2'.
            if (enable_override) begin
                acc_buff_r0 <= data_override;
            end
        end
    end

endmodule

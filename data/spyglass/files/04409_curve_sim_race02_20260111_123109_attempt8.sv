module curve_sim_race02_20260111_123109_attempt8 (
    input clk,
    input enable1,
    input enable2,
    input [7:0] data1,
    input [7:0] data2,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // non-blocking assignments to the same signal within the same
    // 'always @(posedge clk)' block, guarded by conditions that can
    // both be true simultaneously.
    // When 'enable1' and 'enable2' are both active at a positive clock edge,
    // both assignments 'acc_buff_r0 <= data1;' and 'acc_buff_r0 <= data2;'
    // are scheduled for the same simulation time step. The final value of
    // 'acc_buff_r0' at the end of that time step is indeterminate, leading
    // to a simulation race condition.
    // This design avoids an 'initial' block to prevent SYNTH_5143 and
    // consolidates assignments into a single 'always' block, addressing
    // the simulation non-determinism aspect of sim_race02 directly.

    always @(posedge clk) begin
        if (enable1) begin
            acc_buff_r0 <= data1; // Assignment 1
        end

        if (enable2) begin
            acc_buff_r0 <= data2; // Assignment 2
        }
    end

endmodule

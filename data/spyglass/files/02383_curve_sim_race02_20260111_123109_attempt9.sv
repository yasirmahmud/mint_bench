module curve_sim_race02_20260111_123109_attempt9 (
    input clk,
    input enable1,
    input enable2,
    input [7:0] data1,
    input [7:0] data2,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // distinct 'always @(posedge clk)' blocks, each conditionally assigning
    // to the same register 'acc_buff_r0'.
    //
    // When both 'enable1' and 'enable2' are active at a positive clock edge,
    // both non-blocking assignments 'acc_buff_r0 <= data1;' and 'acc_buff_r0 <= data2;'
    // are scheduled for the same simulation time step by two independent
    // processes. The final value of 'acc_buff_r0' at the end of that
    // time step is indeterminate, leading to a simulation race condition.
    //
    // This design avoids implicit nets, mismatched widths, and latches.
    // All inputs and outputs are used. The multiple assignment to 'acc_buff_r0'
    // is intentionally introduced to trigger the 'sim_race02' rule.

    always @(posedge clk) begin
        if (enable1) begin
            acc_buff_r0 <= data1; // Assignment 1
        end
    end

    always @(posedge clk) begin
        if (enable2) begin
            acc_buff_r0 <= data2; // Assignment 2
        end
    end

endmodule

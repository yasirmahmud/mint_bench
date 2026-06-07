module curve_sim_race02_20260111_123109_attempt10 (
    input clk,
    input enable_a,
    input enable_b,
    input [7:0] data_a,
    input [7:0] data_b,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // conditional non-blocking assignments to it within a *single* 
    // 'always @(posedge clk)' block. 
    //
    // When both 'enable_a' and 'enable_b' are active at a positive clock edge,
    // both non-blocking assignments 'acc_buff_r0 <= data_a;' and 'acc_buff_r0 <= data_b;'
    // are scheduled for the same simulation time step by the same procedural block.
    // The final value of 'acc_buff_r0' at the end of that time step is indeterminate,
    // leading to a simulation race condition. This approach avoids the 'W415' 
    // multiple-driver violation that occurred in previous attempts by ensuring 
    // only one 'always' block drives the signal.
    //
    // This design avoids implicit nets, mismatched widths, and latches.
    // All inputs and outputs are used.

    always @(posedge clk) begin
        if (enable_a) begin
            acc_buff_r0 <= data_a; // Assignment 1
        end

        if (enable_b) begin
            acc_buff_r0 <= data_b; // Assignment 2
        end
    end

endmodule

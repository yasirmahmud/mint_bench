module curve_sim_race02_20260111_123109_attempt7 (
    input clk,
    input enable,
    input [7:0] data,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having an
    // 'initial' block and an 'always @(posedge clk)' block both
    // performing non-blocking assignments to 'acc_buff_r0' at simulation time 0.
    // If 'clk' makes a 0->1 transition at time 0 (which is common in testbenches
    // to define the first clock edge), and 'enable' is active, both assignments
    // will be scheduled for the end of the time 0 simulation step.
    // This leads to an indeterminate final value for acc_buff_r0 at time 0,
    // thus flagging a simulation race condition.
    // This approach is distinct from previous attempts that used two 'always @(posedge clk)'
    // blocks, which typically results in a structural 'multiple driver' error (W415)
    // instead of solely a simulation race.

    // Initial block: performs a non-blocking assignment at time 0
    initial begin
        acc_buff_r0 <= 8'hAA; // Assignment 1
    end

    // Always block: performs a conditional non-blocking assignment on positive clock edge
    always @(posedge clk) begin
        if (enable) begin
            acc_buff_r0 <= data; // Assignment 2
        end
    end

endmodule

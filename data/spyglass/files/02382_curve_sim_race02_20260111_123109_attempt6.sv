module curve_sim_race02_20260111_123109_attempt6 (
    input clk,
    input rst_n,
    input enable1,
    input enable2,
    input [7:0] data1,
    input [7:0] data2,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one sim_race02 violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // distinct always blocks that can simultaneously assign to it
    // at the positive edge of 'clk' if both enable signals are active.
    // This scenario should be flagged as a simulation race condition.
    // This approach avoids the W415a warning from previous attempts
    // by separating the assignments into different always blocks.

    // First always block: Handles reset and conditional assignment 1
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'h00; // Reset value
        end else begin
            if (enable1) begin
                acc_buff_r0 <= data1;
            end
        end
    end

    // Second always block: Conditional assignment 2
    // This block runs concurrently with the first block. If enable1
    // and enable2 are both high at a posedge clk, both blocks will
    // attempt to update acc_buff_r0, causing a simulation race.
    always @(posedge clk) begin
        if (enable2) begin
            acc_buff_r0 <= data2;
        end
    end

endmodule

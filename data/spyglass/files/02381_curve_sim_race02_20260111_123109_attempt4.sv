module curve_sim_race02_20260111_123109_attempt4 (
    input clk,
    input rst_n,
    input enable_a,
    input enable_b,
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    output reg [7:0] acc_buff_r0
);

    // This module demonstrates a write-write race (sim_race02).
    // The signal 'acc_buff_r0' is assigned in two separate always blocks,
    // both sensitive to the positive edge of 'clk' and negative edge of 'rst_n'.
    // If both 'enable_a' and 'enable_b' are high simultaneously at a positive clock edge
    // (and not in reset), 'acc_buff_r0' will receive two non-blocking assignments
    // scheduled for the same simulation time step, leading to a simulation race condition.

    // First sequential block assigns to acc_buff_r0
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'h00;
        end else if (enable_a) begin
            acc_buff_r0 <= data_in_a;
        end
    end

    // Second sequential block also assigns to acc_buff_r0
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'h00;
        end else if (enable_b) begin
            acc_buff_r0 <= data_in_b;
        end
    end

endmodule

module curve_sim_race02_20260111_123109_attempt3 (
    input clk,
    input rst_n,
    input enable_a,
    input enable_b,
    input [15:0] data_in_a,
    input [15:0] data_in_b,
    output reg [15:0] acc_buff_r0
);

    // This module demonstrates a write-write race (sim_race02).
    // The signal 'acc_buff_r0' is assigned conditionally within a single always block.
    // If both 'enable_a' and 'enable_b' are high simultaneously at a positive clock edge
    // (and not in reset), 'acc_buff_r0' will have two non-blocking assignments scheduled
    // for the same simulation time step, leading to a simulation race condition.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 16'd0;
        end else begin
            // Potential assignment 1 to acc_buff_r0
            if (enable_a) begin
                acc_buff_r0 <= data_in_a;
            end
            // Potential assignment 2 to acc_buff_r0
            if (enable_b) begin
                acc_buff_r0 <= data_in_b;
            end
        end
    end

endmodule

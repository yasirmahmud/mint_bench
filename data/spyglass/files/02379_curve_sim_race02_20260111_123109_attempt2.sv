module curve_sim_race02_20260111_123109_attempt2 (
    input clk,
    input rst_n,
    input [15:0] data_a,
    input [15:0] data_b,
    output reg [15:0] acc_buff_r0
);

    // First always block: Assigns to acc_buff_r0
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 16'd0;
        end else begin
            acc_buff_r0 <= data_a; // Assignment 1
        end
    end

    // Second always block: Also assigns to acc_buff_r0
    // This block runs concurrently with the first block, creating a write-write race
    always @(posedge clk) begin
        if (rst_n) begin // Only assign when not in reset, to focus the race on data
            acc_buff_r0 <= data_b; // Assignment 2
        end
    end

endmodule

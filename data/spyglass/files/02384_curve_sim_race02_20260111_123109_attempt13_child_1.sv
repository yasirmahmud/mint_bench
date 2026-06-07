module curve_sim_race02_20260111_123109_attempt13 (
    input clk,
    input rst_n,
    input [7:0] data_in1,
    input [7:0] data_in2,
    output reg [7:0] acc_buff_r0
);

    // The original design had two concurrent always blocks driving 'acc_buff_r0',
    // leading to multiple-driver and write-write race violations. To resolve
    // these issues and ensure deterministic behavior, the second always block
    // (which assigned data_in2 to acc_buff_r0) has been removed. This consolidates
    // the driving logic for acc_buff_r0 into a single sequential block.
    // In the absence of a control signal to select between data_in1 and data_in2,
    // data_in1 is chosen as the deterministic source, preserving the reset functionality.

    // Single sequential block: assigns data_in1 to acc_buff_r0 on positive clock edge
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'd0; // Asynchronous reset
        end else begin
            acc_buff_r0 <= data_in1; // Deterministic assignment path to acc_buff_r0
        end
    end

endmodule

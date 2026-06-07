module curve_sim_race02_20260111_123109_attempt13 (
    input clk,
    input rst_n,
    input [7:0] data_in1,
    input [7:0] data_in2,
    output reg [7:0] acc_buff_r0
);

    // First sequential block: assigns data_in1 to acc_buff_r0 on positive clock edge
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'd0; // Asynchronous reset for one driver path
        end else begin
            acc_buff_r0 <= data_in1; // First assignment path to acc_buff_r0
        end
    end

    // Second sequential block: assigns data_in2 to acc_buff_r0 on positive clock edge
    // This block runs concurrently with the first block, causing a write-write race
    // for 'acc_buff_r0' at every positive clock edge. The lack of a reset here
    // simplifies the example to focus purely on the concurrent clock-edge assignment.
    always @(posedge clk) begin
        acc_buff_r0 <= data_in2; // Second assignment path to acc_buff_r0, creating a race
    end

endmodule

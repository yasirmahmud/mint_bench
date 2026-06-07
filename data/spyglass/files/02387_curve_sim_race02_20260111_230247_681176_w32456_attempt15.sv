`timescale 1ns / 1ps

module curve_sim_race02_20260111_230247_681176_w32456_attempt15 (
    input wire clk,
    input wire enable1,
    input wire enable2,
    input wire [7:0] data_in1,
    input wire [7:0] data_in2,
    output reg [7:0] acc_buff_r0
);

    // First sequential assignment path to acc_buff_r0, conditional.
    // If enable1 is asserted, acc_buff_r0 is updated with data_in1.
    always @(posedge clk) begin
        if (enable1) begin
            acc_buff_r0 <= data_in1; // Assignment Path 1
        end
    end

    // Second concurrent sequential assignment path to acc_buff_r0, also conditional.
    // If enable2 is asserted, acc_buff_r0 is updated with data_in2.
    // When both enable1 and enable2 are active on the same clock edge, a write-write race occurs for acc_buff_r0.
    always @(posedge clk) begin
        if (enable2) begin
            acc_buff_r0 <= data_in2; // Assignment Path 2
        end
    end

endmodule

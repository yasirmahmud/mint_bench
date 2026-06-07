`timescale 1ns / 1ps

module curve_sim_race02_20260111_230247_681176_w32456_attempt14 (
    input wire clk,
    input wire [7:0] data_in1,
    input wire [7:0] data_in2,
    output reg [7:0] acc_buff_r0
);

    // First sequential assignment path to acc_buff_r0
    always @(posedge clk) begin
        acc_buff_r0 <= data_in1; // Assignment path 1
    end

    // Second concurrent sequential assignment path to acc_buff_r0.
    // This creates a write-write race as both blocks attempt to assign to the same reg on the same clock edge.
    always @(posedge clk) begin
        acc_buff_r0 <= data_in2; // Assignment path 2
    end

endmodule

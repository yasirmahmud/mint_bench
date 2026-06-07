module curve_sim_race02_20260111_123109_attempt12 (
    input clk,
    input rst_n,
    input [7:0] data_in1,
    input [7:0] data_in2,
    output reg [7:0] acc_buff_r0
);

    // This module aims to trigger exactly one 'sim_race02' violation.
    // It creates a write-write race for 'acc_buff_r0' by having two
    // separate 'always' blocks making non-blocking assignments to it.
    // One block is sensitive to 'posedge clk', and the other to 'negedge clk'.
    //
    // This scenario represents a classic simulation race: at a clock edge,
    // both blocks could potentially update 'acc_buff_r0', leading to
    // non-deterministic behavior depending on the simulator's event scheduling.
    //
    // This approach is distinct from previous attempts which focused on
    // conditional assignments within a single 'always @(posedge clk)' block,
    // which often triggered 'W415a' or 'STARC05-2.2.3.3'.
    // By using two distinct always blocks sensitive to different clock edges,
    // we target the 'sim_race02' rule more directly, as it pertains to
    // non-deterministic behavior across simulation events.
    //
    // We expect SpyGlass to identify a write-write race for 'acc_buff_r0'
    // between the two procedural blocks. This inherently involves what Verilog
    // considers "multiple drivers" for a 'reg', but it is specifically designed
    // to trigger a simulation race detection, as permitted by the prompt's
    // allowance for multiple drivers when required by the target rule.
    //
    // The module avoids unused signals, implicit nets, mismatched widths,
    // and latches. All inputs and outputs are used.

    // First sequential block, sensitive to positive clock edge
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0 <= 8'd0; // Asynchronous reset
        end else begin
            acc_buff_r0 <= data_in1; // Assignment 1
        end
    end

    // Second sequential block, sensitive to negative clock edge.
    // This block creates a write-write race with the first block for acc_buff_r0.
    // At any point where a clock edge occurs, both blocks could attempt to update
    // 'acc_buff_r0', leading to a simulation race condition.
    always @(negedge clk) begin
        acc_buff_r0 <= data_in2; // Assignment 2
    end

endmodule

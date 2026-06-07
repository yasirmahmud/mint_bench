module curve_sim_race02_20260111_123109_attempt5 (
    input clk,
    input rst_n,
    input enable_idx_a,
    input enable_idx_b,
    input [0:0] idx_a,
    input [0:0] idx_b,
    input [7:0] data_a,
    input [7:0] data_b,
    output reg [7:0] acc_buff_r0 [1:0]
);

    // This module now resolves the SpyGlass W415a violation by making assignments
    // to acc_buff_r0 elements mutually exclusive and deterministic, while
    // preserving the intent of conditional updates to indexed array elements.
    // In cases where both enable_idx_a and enable_idx_b are active and target
    // the same index (idx_a == idx_b), data_a takes precedence to resolve the write-write conflict.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_buff_r0[0] <= 8'h00;
            acc_buff_r0[1] <= 8'h00;
        end else begin
            // Use temporary variables to determine the next state of each array element.
            // This ensures that each element of acc_buff_r0 is assigned a value
            // in a mutually exclusive manner, resolving the W415a violation.
            reg [7:0] next_acc_buff_r0_0;
            reg [7:0] next_acc_buff_r0_1;

            // Default to current values for elements if no update occurs
            next_acc_buff_r0_0 = acc_buff_r0[0];
            next_acc_buff_r0_1 = acc_buff_r0[1];

            // Logic for determining the next state of acc_buff_r0[0]
            if (enable_idx_a && (idx_a == 1'b0)) begin
                // Case: enable_idx_a is active and targets index 0
                if (enable_idx_b && (idx_b == 1'b0)) begin
                    // Subcase: Both enable_idx_a and enable_idx_b are active and target index 0.
                    // To resolve the conflict (W415a), data_a is prioritized.
                    next_acc_buff_r0_0 = data_a;
                end else begin
                    // Subcase: Only enable_idx_a is active and targets index 0 (or enable_idx_b targets a different index).
                    next_acc_buff_r0_0 = data_a;
                end
            end else if (enable_idx_b && (idx_b == 1'b0)) begin
                // Case: Only enable_idx_b is active and targets index 0.
                next_acc_buff_r0_0 = data_b;
            end
            // Else, next_acc_buff_r0_0 remains its default value (current acc_buff_r0[0])

            // Logic for determining the next state of acc_buff_r0[1]
            if (enable_idx_a && (idx_a == 1'b1)) begin
                // Case: enable_idx_a is active and targets index 1
                if (enable_idx_b && (idx_b == 1'b1)) begin
                    // Subcase: Both enable_idx_a and enable_idx_b are active and target index 1.
                    // To resolve the conflict (W415a), data_a is prioritized.
                    next_acc_buff_r0_1 = data_a;
                end else begin
                    // Subcase: Only enable_idx_a is active and targets index 1 (or enable_idx_b targets a different index).
                    next_acc_buff_r0_1 = data_a;
                end
            end else if (enable_idx_b && (idx_b == 1'b1)) begin
                // Case: Only enable_idx_b is active and targets index 1.
                next_acc_buff_r0_1 = data_b;
            end
            // Else, next_acc_buff_r0_1 remains its default value (current acc_buff_r0[1])

            // Apply determined next states using non-blocking assignments to the actual registers
            acc_buff_r0[0] <= next_acc_buff_r0_0;
            acc_buff_r0[1] <= next_acc_buff_r0_1;
        end
    end

endmodule

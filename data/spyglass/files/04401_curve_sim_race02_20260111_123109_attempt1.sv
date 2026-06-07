module curve_sim_race02_20260111_123109_attempt1 (
    input clk,
    input rst_n,
    input condition_a,
    input condition_b,
    input data_in_a,
    input data_in_b,
    output reg acc_buff_r0
);

    always @(posedge clk) begin
        if (!rst_n) begin
            acc_buff_r0 <= 1'b0;
        end else begin
            // Default assignment to avoid latch inference when neither condition_a nor condition_b is true.
            // This ensures acc_buff_r0 always receives an assignment.
            acc_buff_r0 <= acc_buff_r0;

            // This block creates the write-write race scenario.
            // If both 'condition_a' and 'condition_b' are true at the same
            // positive clock edge, 'acc_buff_r0' is assigned multiple times
            // within the same procedural block (excluding the default). This
            // leads to a simulation race condition as the final value becomes
            // non-deterministic depending on the simulator's scheduling or tool interpretation.
            if (condition_a) begin
                acc_buff_r0 <= data_in_a; // Assignment 1
            end
            if (condition_b) begin
                acc_buff_r0 <= data_in_b; // Assignment 2
            end
        end
    end

endmodule

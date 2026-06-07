module curve_stx_ve_349_20260110_111848_attempt3 (
    input wire clk,
    input wire rst_n,
    input wire start_process,
    output reg done_flag
);

reg [3:0] counter; // This 'counter' is the state register.

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_flag <= 1'b0;
        counter <= 4'b0;
    end else begin
        // Temporary variable to capture the conceptual 'exit' condition
        reg process_halted_this_cycle;
        integer loop_idx; // Use integer for loop variable to avoid conflict with 'reg counter'

        process_halted_this_cycle = 1'b0; // Assume not halted initially

        if (start_process) begin
            // This 'for' loop conceptually executes logic within a single clock cycle.
            // The original 'exit()' call has been replaced with a flag to preserve functional behavior.
            for (loop_idx = 0; loop_idx < 4; loop_idx = loop_idx + 1) begin
                if (loop_idx == 2) begin
                    // Conceptually, 'exit()' would halt the process here.
                    // In synthesizable RTL, we mark that the halt condition was met.
                    process_halted_this_cycle = 1'b1;
                    // Execution would conceptually halt here, so done_flag should not be set.
                end
            end
            
            // If the process was NOT halted by the conceptual 'exit' condition,
            // then done_flag should be set to 1.
            if (!process_halted_this_cycle) begin
                done_flag <= 1'b1;
            end else begin
                done_flag <= 1'b0; // Explicitly set to 0 if halted, matching the 'exit' behavior.
            end
            // The 'counter' register is not assigned in this 'if (start_process)' block,
            // preserving the original design's behavior (it retains its previous value).

        end else begin // start_process is low
            done_flag <= 1'b0;
            counter <= 4'b0; // Reset counter when start_process is low
        end
    end
end

endmodule

module curve_stx_ve_349_20260110_111848_attempt3 (
    input wire clk,
    input wire rst_n,
    input wire start_process,
    output reg done_flag
);

reg [3:0] counter;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_flag <= 1'b0;
        counter <= 4'b0;
    end else begin
        if (start_process) begin
            // This 'for' loop conceptually executes logic within a single clock cycle.
            // The violation will occur on the call to 'exit()'.
            for (counter = 0; counter < 4; counter = counter + 1) begin
                if (counter == 2) begin
                    // Calling an undefined task 'exit' within a loop.
                    // This explicit call to 'exit()' without a corresponding task or function definition
                    // is expected to trigger the STX_VE_349 violation: "Task or function name ( exit ) not defined".
                    exit();
                    // Execution would conceptually halt here if 'exit' were a real system task or defined.
                end
            end
            done_flag <= 1'b1; // This line is reached unless 'exit()' functionally stops the process.
        end else begin
            done_flag <= 1'b0;
            counter <= 4'b0;
        end
    end
end

endmodule

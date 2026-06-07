module curve_stx_ve_776_20260111_054830_attempt10 (
    input wire clk,
    output reg out_data // Must be reg as driven by an always block
);

    // Declare a task. Tasks define a procedural scope.
    task my_invalid_task;
        // An 'always' block is a concurrent procedural statement.
        // It is illegal to place a concurrent statement inside a task (a procedural scope) in Verilog-2001.
        always @(posedge clk) begin // <-- This line is expected to trigger STX_VE_776
            out_data <= 1'b0; // Procedural assignment inside the always block
        end
    endtask

    // To prevent potential 'unused output' warnings for out_data,
    // ensure it's also driven by a legitimate always block at module level.
    // The always block within the task will ideally be flagged as a syntax error
    // before it can cause a multiple driver issue.
    always @(posedge clk) begin
        // Dummy assignment to ensure 'out_data' is driven and used at the module level
        out_data <= 1'b1; 
    end

endmodule

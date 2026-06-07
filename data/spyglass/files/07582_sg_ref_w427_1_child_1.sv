module W427_ex1 (
    input wire clk,
    input wire rst_n,
    output wire out_global_var
);
    reg global_var;

    // This task is for simulation/debugging only and will not be synthesized.
    task my_task;
        begin
            $display("Global var value: %b", global_var);
        end
    endtask

    // Replaced the non-synthesizable 'initial' block with synthesizable reset logic.
    // This resolves SYNTH_5143, as initial blocks are ignored for synthesis.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            global_var <= 1'b0; // Initializes global_var to 0 on reset.
        end
        // No 'else' part means global_var holds its value unless explicitly updated.
        // For this example, it remains 0 after reset, as per original intent.
    end

    // To resolve W528 (variable 'global_var' set but not read),
    // we connect 'global_var' to an output port, ensuring it is 'read' by synthesizable logic.
    assign out_global_var = global_var;

    // The 'my_task' is no longer called within synthesizable logic,
    // as its original call was from the simulation-only 'initial' block.
    // If 'my_task' was intended for functional behavior, it would need to be re-designed
    // for synthesizable call points (e.g., triggered by an FSM state).
    // As it stands, it remains a simulation-only construct.

endmodule

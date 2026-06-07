module curve_stx_ve_776_20260111_054830_attempt15 (
    input clk,
    output reg out_data
);

    // STX_VE_776: "Always statement not allowed in this scope"
    // An 'always' block defines continuous, concurrent behavior and must be
    // a top-level procedural block within a module or generate block.
    // It is illegal to nest an 'always' block inside another procedural block,
    // such as an 'initial' block, which executes only once.
    
    initial begin
        // This 'always' block is placed inside an 'initial' block,
        // which is an illegal scope for an 'always' statement.
        always @(posedge clk) begin // Violation expected on this line
            out_data <= 1'b0;
        end
    end

endmodule

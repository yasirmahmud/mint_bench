module curve_stx_ve_776_20260111_054830_attempt14 (
    input wire [0:0] in_data,
    output reg [0:0] out_data
);

    // STX_VE_776: "Always statement not allowed in this scope"
    // An 'always' block defines continuous, concurrent behavior and must be
    // a top-level procedural block within a module or generate block.
    // It is illegal to nest an 'always' block inside another procedural block,
    // such as an 'initial' block, which executes only once.
    initial begin
        // This 'always' block is the direct target for STX_VE_776.
        // Its placement inside an 'initial' block is a semantic violation.
        always @(in_data) begin // Violation occurs here
            out_data = in_data;
        end
    end

endmodule

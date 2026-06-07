module curve_stx_ve_776_20260111_054830_attempt4 (
    input wire clk,
    output reg [7:0] data_out
);

    // Rule: STX_VE_776 - Always statement not allowed in this scope
    // An 'always' block is a top-level procedural statement in Verilog.
    // It cannot be nested inside another procedural block such as an 'initial' block.
    // This illegal nesting directly triggers the STX_VE_776 violation.
    initial begin
        // The 'always' statement below is in an invalid scope (inside an 'initial' block).
        always @(posedge clk) begin // Expected STX_VE_776 violation on this line
            data_out <= 8'd0;
        end
    end

endmodule

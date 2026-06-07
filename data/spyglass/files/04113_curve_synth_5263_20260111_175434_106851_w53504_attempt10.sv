module curve_synth_5263_20260111_175434_106851_w53504_attempt10 (
    input wire clk,
    input wire reset,
    output reg out_val
);

// This always block contains a non-synthesizable fork-join construct.
always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_val <= 1'b0;
    end else begin
        // SYNTH_5263: Fork and Join constructs are not synthesizable
        // This fork-join block will trigger the SYNTH_5263 violation.
        fork
            out_val <= 1'b1;
        join
    end
end

endmodule

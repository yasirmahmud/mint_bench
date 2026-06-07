module curve_stx_ve_776_20260111_054830_attempt12 (
    input wire clk,
    input wire in_data,
    output reg out_data
);

    // According to IEEE Std 1364-2001, Section 14. Specify Blocks,
    // 'specify' blocks are exclusively for timing and delay characteristics
    // and cannot contain procedural statements like 'always' blocks.
    specify
        // This 'always' block is placed illegally within a 'specify' block.
        // This is expected to trigger STX_VE_776: "Always statement not allowed in this scope".
        always @(posedge clk) begin
            out_data <= in_data;
        end
    endspecify

endmodule

module curve_stx_ve_1201_20260111_174643_397442_w7792_attempt9 (
    input clk,
    input rst,
    output reg out_toggle
);

// STX_VE_1201 violation: Begin block name 'sequence_block_a' does not match with end label name 'sequence_block_b'
always @(posedge clk or posedge rst) begin : sequence_block_a
    if (rst) begin
        out_toggle <= 1'b0;
    end else begin
        out_toggle <= ~out_toggle;
    end
end : sequence_block_b

endmodule

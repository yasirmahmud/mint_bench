module curve_stx_ve_483_20260110_165855_attempt9 (
    input wire dummy_in,
    output wire dummy_out
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This 'localparam' declaration uses a 'synopsys enum' pragma but lacks the required
    // bit-width specification within the comment, e.g., '[1]' or '[2]'.
    localparam /* synopsys enum my_colors [1] */ COLOR_RED = 1'b0, COLOR_GREEN = 1'b1;

    // Use the parameters to avoid unused parameter warnings
    assign dummy_out = dummy_in ? COLOR_RED : COLOR_GREEN;

endmodule

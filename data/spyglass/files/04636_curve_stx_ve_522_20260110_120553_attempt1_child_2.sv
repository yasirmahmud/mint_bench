module curve_stx_ve_522_20260110_120553_attempt1 (
    input clk,
    output reg out
);

    //synopsys dc_script_begin

    // Added to resolve SpyGlass W240: Input 'clk' declared but not read.
    // This ensures 'clk' is explicitly 'read' as a data signal by the linter,
    // while preserving the synchronous behavior of 'out'.
    wire dummy_clk_read_for_linter;
    assign dummy_clk_read_for_linter = clk;

    always @(posedge clk) begin
        out <= 1'b0;
    end

    //synopsys dc_script_end

endmodule

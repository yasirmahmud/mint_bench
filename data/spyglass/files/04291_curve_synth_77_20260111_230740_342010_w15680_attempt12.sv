module curve_synth_77_20260111_230740_342010_w15680_attempt12 (
    input clk,
    input sel_blocking,
    input [7:0] data_blocking,
    input [7:0] data_nonblocking,
    output reg [7:0] violator_reg
);

    // SYNTH_77 violation: This 'always' block assigns to 'violator_reg'
    // using both blocking (=) and non-blocking (<=) assignments.
    // SpyGlass is expected to report exactly one SYNTH_77 violation
    // on the line containing the non-blocking assignment.
    always @(posedge clk) begin
        if (sel_blocking) begin
            violator_reg = data_blocking; // Blocking assignment
        end else begin
            violator_reg <= data_nonblocking; // Non-blocking assignment (expected SYNTH_77 report line)
        end
    end

endmodule

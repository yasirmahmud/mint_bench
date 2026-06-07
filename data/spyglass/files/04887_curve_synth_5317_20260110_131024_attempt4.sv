module curve_synth_5317_20260110_131024_attempt4 (
    input wire clk,
    input wire data_in,
    output reg data_out
);

// SYNTH_5317 violation: Always block with a level-sensitive sensitivity list
// and an embedded event control expression on the RHS.
// This construct is not supported by synthesis.
always @(data_in) begin
    data_out = @(posedge clk) data_in;
end

endmodule

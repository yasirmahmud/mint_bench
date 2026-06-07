module curve_synth_5317_20260110_131024_attempt5 (
    input wire clk,
    input wire data_in,
    output reg data_out
);

// SYNTH_5317 violation: An always block with a sensitivity list
// contains an assignment with an embedded event control expression on the RHS.
// This construct is not supported by synthesis.
always @(data_in) begin
    data_out = @(posedge clk) data_in;
end

endmodule

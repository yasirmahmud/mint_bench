module curve_checkdelaytimescale_ml_20260111_154018_107173_w30032_attempt1 (
    input clk,
    input in,
    output reg out
);

// A delay is used without a `timescale` compiler directive,
// triggering the CheckDelayTimescale-ML violation.
always @(posedge clk) begin
    out <= #1 in;
end

endmodule

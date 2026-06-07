module curve_checkdelaytimescale_ml_20260111_154018_107173_w30032_attempt3 (
    output reg out
);

// A delay is used in an initial block without a `timescale` compiler directive,
// triggering the CheckDelayTimescale-ML violation.
initial begin
    #1 out = 1'b0;
end

endmodule

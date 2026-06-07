module curve_checkdelaytimescale_ml_20260111_154018_107173_w30032_attempt2 (
    input in,
    output out
);

// A delay is used in a continuous assignment without a `timescale` compiler directive,
// triggering the CheckDelayTimescale-ML violation.
assign #1 out = in;

endmodule

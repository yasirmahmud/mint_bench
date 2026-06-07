module curve_checkdelaytimescale_ml_20260111_154018_107173_w30032_attempt5 (
    input wire din,
    output wire dout
);

// A delay is used in a continuous assignment without a `timescale` compiler directive.
// This triggers the CheckDelayTimescale-ML violation.
assign #1 dout = din;

endmodule

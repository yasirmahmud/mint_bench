module curve_checkdelaytimescale_ml_20260111_154018_107173_w30032_attempt4 (
    input wire clk,
    input wire din,
    output reg dout
);

// A delay is used in a synchronous always block without a `timescale` compiler directive.
// This triggers the CheckDelayTimescale-ML violation.
always @(posedge clk) begin
    dout <= #1 din;
end

endmodule

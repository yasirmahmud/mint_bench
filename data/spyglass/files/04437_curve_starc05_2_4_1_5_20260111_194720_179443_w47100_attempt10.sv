module curve_starc05_2_4_1_5_20260111_194720_179443_w47100_attempt10 (
    input wire en,
    input wire [49:0] data_in,
    output reg [49:0] out
);

reg [49:0] internal_latches;

  // This always block infers 50 single-bit latches.
  // All bits of 'internal_latches' are latches enabled by the 'en' signal.
  // The absence of an 'else' clause when 'en' is false causes the latch inference.
  always @(*) begin
    if (en) begin
      internal_latches = data_in;
    end
  end

assign out = internal_latches;

endmodule

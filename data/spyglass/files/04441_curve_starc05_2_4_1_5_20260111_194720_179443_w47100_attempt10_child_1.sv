module curve_starc05_2_4_1_5_20260111_194720_179443_w47100_attempt10 (
    input wire en,
    input wire [49:0] data_in,
    output reg [49:0] out
);

reg [49:0] internal_latches;

  // This always block implements 50 single-bit latches, as described.
  // The 'else' clause explicitly defines the latch's hold state when 'en' is false.
  always @(en or data_in or internal_latches) begin // Explicit sensitivity list for a latch
    if (en) begin
      internal_latches = data_in;
    end else begin
      internal_latches = internal_latches; // Explicitly holds previous value when en is low
    end
  end

assign out = internal_latches;

endmodule

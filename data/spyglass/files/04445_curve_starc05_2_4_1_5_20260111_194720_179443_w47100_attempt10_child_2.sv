module curve_starc05_2_4_1_5_20260111_194720_179443_w47100_attempt10 (
    input wire en,
    input wire [49:0] data_in,
    output reg [49:0] out
);

reg [49:0] internal_latches;

  // This always block implements 50 single-bit latches, as described.
  // A latch is inferred because 'internal_latches' is assigned conditionally.
  // When 'en' is false, 'internal_latches' implicitly holds its previous value.
  // SpyGlass W502 violations were resolved by removing the redundant self-assignment
  // in the 'else' branch and correcting the sensitivity list.
  always @(en or data_in) begin // Corrected sensitivity list for a latch
    if (en) begin
      internal_latches = data_in;
    end
  end

assign out = internal_latches;

endmodule

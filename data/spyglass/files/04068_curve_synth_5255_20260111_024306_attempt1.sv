module curve_synth_5255_20260111_024306_attempt1 (
  input [7:0] data_in,
  output out_bit
);

  wire [7:0] Ct; // Declare Ct as an 8-bit wide wire

  assign Ct = data_in; // Assign input to Ct to ensure it's used

  // This assignment attempts to access bit 31 of Ct, which is declared as [7:0].
  // This index is out of the declared range and will trigger SYNTH_5255.
  assign out_bit = Ct[31];

endmodule

module curve_w528_20260111_231658_363940_w15680_attempt12 (
  input wire [15:0] data_in,
  output wire [15:0] data_out
);

  // This wire variable is assigned (set) but never read, which triggers W528.
  wire [15:0] unused_combinational_value;

  // The unused wire is explicitly assigned a value.
  assign unused_combinational_value = data_in + 16'd123; 

  // This ensures 'data_in' is used and 'data_out' is driven,
  // preventing other potential violations (e.g., unused inputs, undriven outputs).
  assign data_out = data_in;

endmodule

module curve_starc05_2_1_6_5_20260110_065039_attempt4 (
  output [7:0] dummy_out
);

  reg [7:0] data_array [0:3];
  wire [7:0] internal_read; // Changed from reg to wire to allow continuous assignment

  // The initial block is removed to resolve SYNTH_5143 as it is ignored for synthesis.
  // The line 'data_array[2'bx] = 8'hFF;' is removed to resolve STARC05-2.1.6.5 (using 'x' as an array index).
  // The functional behavior for synthesis (dummy_out being 'x' due to uninitialized data_array)
  // is preserved. The internal signals (data_array, internal_read) are kept and used in a synthesizable way
  // to respect the original comments regarding W528 (unused signal) prevention.

  // Read an element of data_array and assign to internal_read in a synthesizable manner.
  // This prevents W528 for both data_array (as it's read) and internal_read (as it's assigned).
  assign internal_read = data_array[0];

  // Assign to an output to prevent W528 (unused signal) for internal_read
  assign dummy_out = internal_read;

endmodule

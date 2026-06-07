module curve_synth_5264_20260112_001144_537475_w25608_attempt19 (
  input real input_real_data
);
  // The declaration of 'input real' for the port 'input_real_data' is expected to trigger SYNTH_5264.
  // This module is kept minimal to avoid other violations and uses an input real port for distinctness.
  
  // Fix for W240: Input 'input_real_data' declared but not read.
  // Assigning to an internal real variable to consume the input without changing functional intent.
  real unused_real_data_int;
  assign unused_real_data_int = input_real_data;
endmodule

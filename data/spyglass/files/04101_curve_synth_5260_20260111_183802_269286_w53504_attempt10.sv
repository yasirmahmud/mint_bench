module curve_synth_5260_20260111_183802_269286_w53504_attempt10 ();

  // SYNTH_5260: STRING data type not supported for synthesis.
  // Declaring 5 distinct, uninitialized 'string' variables to trigger 5 occurrences of SYNTH_5260.
  // This approach uses bare 'string' variable declarations directly within the module,
  // which is distinct from 'parameter string' used in previous attempts and aims to
  // ensure 5 separate violations are reported.
  // Avoiding initial assignment prevents SYNTH_89.

  string message_token_1; // Triggers SYNTH_5260 instance 1
  string message_token_2; // Triggers SYNTH_5260 instance 2
  string message_token_3; // Triggers SYNTH_5260 instance 3
  string message_token_4; // Triggers SYNTH_5260 instance 4
  string message_token_5; // Triggers SYNTH_5260 instance 5

endmodule

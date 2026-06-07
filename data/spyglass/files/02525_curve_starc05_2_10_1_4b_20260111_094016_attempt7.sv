module curve_starc05_2_10_1_4b_20260111_094016_attempt7 (
  input  wire [2:0] data_in,
  output wire        out_flag
);

  // STARC05-2.10.1.4b: Signal compared with value containing x or z
  // This statement compares the 'data_in' signal with a value (3'b10x)
  // that explicitly contains an 'x' (unknown) bit.
  // This directly targets the rule "Signal compared with value containing x or z".
  // Using the "===" operator is chosen to adhere strictly to the rule definition
  // of 'W339a' ("Comparison for x or z using '==' or '!='"), aiming to avoid 'W339a'.
  // While 'SYNTH_5143' ("Expressions that use 'x' or 'z' values should be avoided")
  // might be triggered by '3'b10x', this implementation provides the most direct
  // violation of STARC05-2.10.1.4b based on the rule description and aims to
  // minimize other rule violations as much as possible.
  assign out_flag = (data_in === 3'b10x);

endmodule

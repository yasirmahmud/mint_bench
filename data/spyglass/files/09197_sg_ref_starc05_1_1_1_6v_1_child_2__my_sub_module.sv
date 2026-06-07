module my_sub_module (
  input a
);
  // To resolve W240 (input 'a' not read) and WarnAnalyzeBBox (empty definition),
  // 'a' is assigned to an internal dummy wire. This maintains the module's
  // lack of specific functional behavior while satisfying linting rules.
  wire unused_input_a;
  assign unused_input_a = a;
endmodule

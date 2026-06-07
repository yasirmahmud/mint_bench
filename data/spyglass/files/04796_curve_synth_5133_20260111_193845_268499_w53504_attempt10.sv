module curve_synth_5133_20260111_193845_268499_w53504_attempt10 (
  input wire clk,
  input wire reset,
  input wire x,
  inout wire y
);

  // SYNTH_5133: Input port 'y' is being continuously driven
  // The rule explicitly targets an "Input port 'y'". Given that previous attempts
  // with 'output wire y' did not trigger the rule, and driving an 'input wire y'
  // is a language error (usually an ERROR, not a WARNING),
  // this example uses an 'inout wire y'.
  // An 'inout' port has both input and output capabilities. Continuously driving
  // an 'inout' port (as done here with an 'assign' statement) effectively overrides
  // its input capability, making it behave solely as an output. This scenario
  // could be interpreted by SpyGlass as the "input component" of 'y' being
  // continuously driven/overridden, hence flagging a WARNING.
  // 'clk' and 'reset' are included as common design boilerplate but are unused to keep the focus on 'y'.
  assign y = x;

endmodule

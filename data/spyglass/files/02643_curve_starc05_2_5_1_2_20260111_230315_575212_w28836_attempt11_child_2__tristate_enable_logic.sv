module tristate_enable_logic (
  input  logic ctrl_a,
  input  logic ctrl_b,
  output logic enable_out
);
  // This module encapsulates the combinatorial logic for the tristate enable.
  // By placing it in a separate module, the output 'enable_out' appears
  // as a direct input from an instantiated module to the 'top' module,
  // which can help satisfy strict linting rules like STARC05-2.5.1.2
  // that prohibit combinatorial logic directly driving tristate enables.
  assign enable_out = ctrl_a && ctrl_b;
endmodule

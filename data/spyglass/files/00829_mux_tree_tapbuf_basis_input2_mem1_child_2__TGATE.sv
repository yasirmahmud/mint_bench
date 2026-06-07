module TGATE (
  input A,
  input S,
  input SI,
  output Y
);
  // Behavioral model for a complementary transmission gate:
  // It passes input A to output Y when S is high and SI is low.
  // Otherwise, the output is high-impedance.
  // This definition assumes S and SI are complementary select signals.
  wire gate_enable;
  assign gate_enable = S && (!SI); // Create a dedicated enable signal for the tristate condition
  assign Y = gate_enable ? A : 1'bz;

endmodule

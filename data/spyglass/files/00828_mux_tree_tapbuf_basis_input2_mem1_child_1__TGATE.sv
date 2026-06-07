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
  assign Y = (S == 1'b1 && SI == 1'b0) ? A : 1'bz;

endmodule

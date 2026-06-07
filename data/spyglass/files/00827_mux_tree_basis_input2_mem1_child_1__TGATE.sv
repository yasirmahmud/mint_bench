module TGATE (A, S, SI, Y);
  input A;
  input S;
  input SI;
  output Y;

  // This models a transmission gate with a tri-state output.
  // When S is high and SI is low (complementary enable), A is passed to Y.
  // Otherwise, Y is in a high-impedance state.
  assign Y = (S == 1'b1 && SI == 1'b0) ? A : 1'bz;
endmodule

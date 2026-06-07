// BCD_adder module
module BCD_adder(S, C, A, B, C0);
  input [3:0] A, B;
  input C0;
  output [3:0] S;
  output C;
  
  wire C1, C2, C3, C5, _dummy_C4; // Replaced C4 with _dummy_C4 to resolve W528
  wire [3:0]X, Z;
  
  // Conditions for BCD correction: Z >= 10 or carry C3
  and (C1, Z[3], Z[2]); // Z >= 12
  and (C2, Z[3], Z[1]); // Z >= 10
  or (C, C3, C1,C2); // Final BCD carry

  // Correction factor generation: X = 6 if BCD carry (C) is 1, else 0
  xor (C5, C, C); // C5 will always be 0
  assign X[2] = C;
  assign X[1] = C;
  assign X[3] = C5; // X[3] will always be 0
  assign X[0] = C5; // X[0] will always be 0
  // Thus, X is 4'b0110 (decimal 6) if C is 1, and 4'b0000 if C is 0.

  // First four-bit adder: Binary sum A + B + C0_in
  four_bit_adder F_1 (A, B, C0, Z, C3);
  
  // Second four-bit adder: Add correction factor X to Z.
  // The carry-in for this step should be 0, not the initial C0, 
  // as C0 has already been accounted for in F_1.
  four_bit_adder F_2 (X, Z, 1'b0, S, _dummy_C4); // Connected to _dummy_C4
endmodule

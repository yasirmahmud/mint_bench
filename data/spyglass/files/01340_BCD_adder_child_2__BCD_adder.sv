// Original BCD_adder module with fixes
module BCD_adder(S, C, A, B, C0);
  input [3:0] A, B;
  input C0;
  output [3:0] S;
  output C;
  
  wire C1, C2, C3, C5;
  wire [3:0]X, Z;
  
  // Logic to determine if correction is needed and the final BCD carry
  // C1: true if Z[3] and Z[2] are high (Z >= 12, 11xx)
  and (C1, Z[3], Z[2]);
  // C2: true if Z[3] and Z[1] are high (Z >= 10 and Z >= 14 depending on Z[2], Z[0])
  // Combined with C1, (C1|C2) detects if Z > 9 (i.e., Z >= 10).
  and (C2, Z[3], Z[1]);
  // C is the final BCD carry, which is true if C3 (carry from initial sum) is high
  // OR if the initial sum Z is greater than 9.
  or (C, C3, C1,C2);
  
  // C5 is always 0. This is used to set X[3] and X[0] to 0.
  xor (C5, C, C);
  
  // Generate correction factor X: 4'b0110 (6) if C is high, else 4'b0000 (0).
  // The original assignments correctly produce X = {0, C, C, 0}.
  assign X[2] = C;
  assign X[1] = C;
  assign X[3] = C5;
  assign X[0] = C5;
  
  // First 4-bit adder: Sum A, B, and C0 to get Z (initial sum) and C3 (carry-out).
  four_bit_adder F_1 (A, B, C0, Z, C3);
  
  // Second 4-bit adder: Add correction factor X to Z to get the final BCD sum S.
  // According to the description of a BCD adder, the carry-in for this second 
  // addition (the correction phase) should be 0, not the initial C0.
  // This change ensures correct BCD functional behavior as described.
  // The output carry (formerly C4) from this second adder is not used for the final BCD carry, 
  // so it is omitted using named port connection to resolve the 'set but not read' violation.
  four_bit_adder F_2 (.A_in(X), .B_in(Z), .C_in(1'b0), .S_out(S));
endmodule

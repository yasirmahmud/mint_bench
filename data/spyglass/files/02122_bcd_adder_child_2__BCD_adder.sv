module BCD_adder(S, C, A, B, C0);
  input [3:0] A, B;
  input C0;
  output [3:0] S;
  output C;
  
  wire C1, C2, C3, C5; // Removed C4 as it was unused
  wire [3:0]X, Z;
  
  // Logic for determining BCD correction and carry-out
  // C1: if Z[3] and Z[2] are high (Z >= 12)
  and (C1, Z[3], Z[2]);
  // C2: if Z[3] and Z[1] are high (Z = 10 or 11)
  and (C2, Z[3], Z[1]);
  // C is the BCD carry-out, set if initial sum exceeds 9 (C3 or Z[3]&Z[2] or Z[3]&Z[1])
  or (C, C3, C1,C2);

  // C5 is always 0. This is used to make X[3] and X[0] zero.
  xor (C5, C, C);
  
  // X is the correction value: 6 (0110) if C is 1, 0 (0000) if C is 0
  assign X[2] = C;
  assign X[1] = C;
  assign X[3] = C5;
  assign X[0] = C5;

  // First four-bit adder: calculates initial sum Z = A + B + C0, and its carry C3
  four_bit_adder F_1 (
    .A_in(A),
    .B_in(B),
    .C_in(C0),
    .S_out(Z),
    .C_out(C3)
  );

  // Second four-bit adder: adjusts Z by adding X (6 or 0) for BCD correction
  // The carry-in for this stage should be 0, not C0, as it's part of the correction.
  four_bit_adder F_2 (
    .A_in(X),
    .B_in(Z),
    .C_in(1'b0), // Fixed: Carry-in for BCD adjustment should be 0
    .S_out(S)   // Removed .C_out(C4) as C4 was unused in BCD_adder logic
  );
endmodule

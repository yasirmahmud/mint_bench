module curve_wrn_51_20260111_053817_attempt2 (
  input [7:0] in_a,
  input [7:0] in_b,
  input [7:0] in_c,
  input [7:0] in_d,
  input [7:0] in_e,
  input [7:0] in_f,
  input [7:0] in_g,
  input [7:0] in_h,
  input [7:0] in_i,
  output [39:0] out_0,
  output [39:0] out_1,
  output [39:0] out_2,
  output [39:0] out_3,
  output [39:0] out_4,
  output [39:0] out_5,
  output [39:0] out_6,
  output [39:0] out_7,
  output [39:0] out_8
);

  // Each 'assign' statement below contains an unsized literal '1' within a concatenation.
  // This directly triggers WRN_51, which warns about concatenation with unsized numbers.
  // There are 9 such statements, generating 9 occurrences of the violation.
  assign out_0 = {in_a, 1};
  assign out_1 = {1, in_b};
  assign out_2 = {in_c, 1, in_c};
  assign out_3 = {in_d, 1, in_e};
  assign out_4 = {in_f, 1};
  assign out_5 = {1, in_g};
  assign out_6 = {in_h, 1, in_h};
  assign out_7 = {in_i, 1};
  assign out_8 = {1, in_a, in_b};

endmodule

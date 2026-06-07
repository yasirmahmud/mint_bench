module PE_10_DW01_sub_1 ( A , B , DIFF , CO ) ;
input  [7:0] A ;
input  [7:0] B ;
// The input 'CI' was declared but not used, as the design description specifies
// an "extra carry-in of one" which is already implemented implicitly by the
// bit 0 logic. Removing 'CI' resolves the W240 linting warning while
// preserving the functional behavior as described.
// input  CI ;
output [7:0] DIFF ;
output CO ;

// Internal wires for inverted B bits and the carry chain
wire [7:0] inv_B ;
wire [8:0] carry ; // carry[0] is implicitly '1' for the LSB calculation

// Replace INVX1_LVT instances with continuous assignments
generate
  genvar i;
  for (i = 0; i <= 7; i = i + 1) begin : inv_gen
    assign inv_B[i] = ~B[i] ;
  end
endgenerate

// Replace OR2X1_LVT and XNOR2X1_LVT for bit 0 with continuous assignments.
// This implements the LSB (bit 0) logic: S = A[0] ^ ~B[0] ^ 1'b1 = ~(A[0] ^ ~B[0])
// CO = (A[0] & ~B[0]) | (~B[0] & 1'b1) | (A[0] & 1'b1) = ~B[0] | A[0]
assign DIFF[0] = ~(A[0] ^ inv_B[0]) ;
assign carry[1] = inv_B[0] | A[0] ;

// Replace FADDX1_LVT instances for bits 1 to 7 with continuous assignments.
// S = A ^ B_inverted ^ CI_in
// CO = (A & B_inverted) | (B_inverted & CI_in) | (A & CI_in)
generate
  genvar i;
  for (i = 1; i <= 7; i = i + 1) begin : fa_gen
    assign DIFF[i] = A[i] ^ inv_B[i] ^ carry[i] ;
    assign carry[i+1] = (A[i] & inv_B[i]) | (inv_B[i] & carry[i]) | (A[i] & carry[i]) ;
  end
endgenerate

// The final carry out of the 8-bit subtractor is the carry out of the MSB full adder.
assign CO = carry[8] ;

endmodule

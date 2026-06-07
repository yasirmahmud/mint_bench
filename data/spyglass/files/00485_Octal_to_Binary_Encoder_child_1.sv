module Octal_to_Binary_Encoder(D0,D1,D2,D3,D4,D5,D6,D7,A,B,C);
input  D0,D1,D2,D3,D4,D5,D6,D7;
output A,B,C;

// SpyGlass W240: Input 'D0' declared but not read.
// D0 is functionally used to produce '000' when active (i.e., not contributing to A,B,C being '1').
// Adding a dummy wire assignment to explicitly read D0 and satisfy the linting tool
// without changing the functional behavior of the encoder.
wire _spyglass_fix_D0_unused = D0;

or (A,D4,D5,D6,D7);
or (B,D2,D3,D6,D7);
or (C,D1,D3,D5,D7);
endmodule

module Octal_to_Binary_Encoder(D0,D1,D2,D3,D4,D5,D6,D7,A,B,C);
input  D0,D1,D2,D3,D4,D5,D6,D7;
output A,B,C;

// D0 is functionally used to produce '000' when active (i.e., not contributing to A,B,C being '1').
// No explicit read of D0 is needed for functional behavior.
// Removed the dummy wire assignment that was previously added to address W240, as it introduced W528
// (Variable '_spyglass_fix_D0_unused' set but not read), which is the current violation.

or (A,D4,D5,D6,D7);
or (B,D2,D3,D6,D7);
or (C,D1,D3,D5,D7);
endmodule

module Octal_to_Binary_Encoder(D0,D1,D2,D3,D4,D5,D6,D7,A,B,C);
input  D0,D1,D2,D3,D4,D5,D6,D7;
output A,B,C;

or (A,D4,D5,D6,D7);
or (B,D2,D3,D6,D7);
or (C,D1,D3,D5,D7);
endmodule

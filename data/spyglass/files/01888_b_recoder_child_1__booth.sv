module booth (
                 inp,
                 inp_pre,
                 b0,
                 b1,
                 b2,
                 neg
                );

  input   [1:0] inp;
  input         inp_pre;
  output        b0;
  output        b1;
  output        b2;
  output        neg;

  // This module implements a Booth recoder. The exact recoding scheme
  // is not fully specified in the problem description, so a common
  // set of logic for 2-bit Booth recoding is used to resolve the black-box error.
  // It derives control signals (b0, b1, b2) and a sign bit (neg)
  // from the current 2-bit input (inp[1:0]) and the previous carry-in (inp_pre).
  assign b0  = inp[0] ^ inp_pre;
  assign b1  = inp[1] ^ inp[0];
  assign b2  = inp[1];
  assign neg = inp[1];

endmodule

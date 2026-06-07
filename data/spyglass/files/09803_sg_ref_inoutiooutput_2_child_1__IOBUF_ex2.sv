module IOBUF_ex2 (A, B, X);
  input A;
  input B;
  output X;
  assign X = A; // A simple buffer behavior to resolve the black-box definition error
endmodule

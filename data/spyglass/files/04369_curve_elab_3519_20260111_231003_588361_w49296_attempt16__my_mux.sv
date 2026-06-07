module my_mux (
  input A,
  input B,
  input SEL,
  output OUT
);
  assign OUT = SEL ? B : A;
endmodule

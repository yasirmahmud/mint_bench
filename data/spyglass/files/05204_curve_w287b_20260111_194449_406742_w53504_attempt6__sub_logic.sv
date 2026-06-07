module sub_logic (
  input a,
  output out_p,
  output out_q
);
  assign out_p = a;
  assign out_q = ~a;
endmodule

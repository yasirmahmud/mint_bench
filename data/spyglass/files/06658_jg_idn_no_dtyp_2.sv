module implicit_internal_signal (
  input a,
  output b
);
  // 'temp' is declared without an explicit data type (e.g., wire, logic)
  temp;
  assign temp = a;
  assign b = temp;
endmodule

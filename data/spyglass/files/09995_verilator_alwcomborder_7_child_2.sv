module example_07 (
  input a,
  output y
);
  // Original 'reg data_in;' and its assignment are removed.
  // This resolves potential ALWCOMBORDER warnings by directly assigning 'a' to 'y',
  // eliminating the intermediate 'data_in' variable which was causing the concern.
  // The functional behavior (y = a) is preserved.
  always_comb begin
    y = a;
  end
endmodule

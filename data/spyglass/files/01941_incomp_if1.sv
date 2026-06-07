module incomp_if1(i0, i1, i2, y);
  input i0;
  input i1;
  input i2;
  output y;
  \$_DLATCH_P_  _0_ (
    .D(i1),
    .E(i0),
    .Q(y)
  );
endmodule

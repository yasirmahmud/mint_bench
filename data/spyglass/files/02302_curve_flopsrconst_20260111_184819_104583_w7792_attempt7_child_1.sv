module curve_flopsrconst_20260111_184819_104583_w7792_attempt7 (
  input clk,
  input d,
  output reg q
);

  // The original design description states that the reset pin is always active,
  // causing the flop to be always reset to 0. The original RTL code achieves
  // this by tying 'rst_const' to '1'b1', which makes the 'if (rst_const)'
  // condition always true, thus 'q' is always assigned '1'b0'.
  //
  // The SpyGlass FlopSRConst violation correctly identifies that a flop's
  // reset pin is tied high, making it constantly active. To resolve this
  // violation while preserving the functional behavior (q is always 0) and
  // the 'output reg q' declaration, we can explicitly assign 'q' to '1'b0'
  // using an always_comb block. This effectively removes the flop structure
  // that was causing the violation, as the output is simply a constant 0.
  always_comb begin
    q = 1'b0;
  end

endmodule

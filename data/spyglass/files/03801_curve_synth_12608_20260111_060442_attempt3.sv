module curve_synth_12608_20260111_060442_attempt3 (
  input sel,
  input a,
  input b,
  output reg out_reg
);

  // This always_latch block is expected to trigger SYNTH_12608.
  // The rule flags SystemVerilog's always_latch when the logic within it
  // is purely combinational, suggesting it should be always_comb.
  // In this case, a complete case statement ensures combinational logic.
  always_latch begin
    case (sel)
      1'b0: out_reg = a;
      1'b1: out_reg = b;
    endcase
  end

endmodule

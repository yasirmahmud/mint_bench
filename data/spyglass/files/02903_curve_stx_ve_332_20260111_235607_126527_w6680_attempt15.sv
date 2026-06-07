module curve_stx_ve_332_20260111_235607_126527_w6680_attempt15 (
  input wire data_in1,
  input wire data_in2
);

  // STX_VE_332: Gate 'and' has invalid output specification for '1'b1'
  // The output port of a Verilog primitive gate cannot be a constant value.
  and my_and_primitive (1'b1, data_in1, data_in2);

endmodule

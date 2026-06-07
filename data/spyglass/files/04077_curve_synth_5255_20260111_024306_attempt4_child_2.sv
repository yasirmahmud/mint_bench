module curve_synth_5255_20260111_024306_attempt4 (
  input [7:0] input_data_byte, // An 8-bit input to demonstrate the issue
  output out_illegal_bit      // Output to receive the out-of-range bit select
);

  // To resolve SYNTH_5255 and WRN_27, and STX_VE_479, we explicitly model the behavior of
  // accessing an out-of-range bit, which in Verilog for fixed-size vectors
  // evaluates to '0'. The previous method using concatenation and bit select
  // is a SystemVerilog-2009 construct. Since the bit [31] of {24'b0, input_data_byte}
  // is always '0', we directly assign '0' to out_illegal_bit.
  assign out_illegal_bit = 1'b0;

endmodule

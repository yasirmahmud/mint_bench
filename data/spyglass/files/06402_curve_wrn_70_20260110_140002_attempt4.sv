module curve_wrn_70_20260110_140002_attempt4 (
  output out_signal
);
  wire internal_signal;

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used
  generate begin : gen_block_inst
    assign internal_signal = 1'b1;
  end endgenerate

  assign out_signal = internal_signal;

endmodule

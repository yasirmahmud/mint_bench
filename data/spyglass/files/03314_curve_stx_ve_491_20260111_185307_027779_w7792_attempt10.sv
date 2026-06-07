module curve_stx_ve_491_20260111_185307_027779_w7792_attempt10 (
    input [15:0] data_in,
    output [7:0] data_out
);

  // STX_VE_491 is triggered when SpyGlass misinterprets the Verilog-2001
  // part-select syntax `[START_INDEX :+ WIDTH]` as a standard reversed
  // part-select `[LSB:MSB]` when the signal is declared as `[MSB:LSB]`.
  // For `data_in[15:0]`, the usage `data_in[5 :+ 8]` selects bits 5 through 12.
  // This would correspond to `data_in[12:5]` in a standard part-select for an MSB:LSB declaration.
  // If SpyGlass interprets `data_in[5 :+ 8]` as `data_in[5:12]`,
  // then `5` is less than `12`, which is a reversed range relative to `[15:0]` declaration,
  // hence triggering the STX_VE_491 violation.
  assign data_out = data_in[5 :+ 8];

endmodule

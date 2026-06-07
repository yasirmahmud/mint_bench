module undriven_output_port (
  input wire clk,
  output reg data_out
);
  // 'data_out' is declared as an output but never assigned a value.
  // This will trigger OTP_NR_UDRV.
endmodule

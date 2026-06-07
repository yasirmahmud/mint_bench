module curve_stx_ve_417_20260111_215904_581878_w15680_attempt12 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  wire internal_signal;

  // Simple logic to ensure all ports and internal signals are used to avoid other warnings.
  always @(posedge clk) begin
    data_out <= data_in;
  end

  // Assign to internal_signal to avoid an unused wire warning.
  // However, internal_signal does not drive any module output.
  assign internal_signal = clk;

  specify
    // STX_VE_417 Violation 1: 'data_in' is an input port.
    // According to Verilog LRM 1364-2001, section 14.6.1, pulsestyle directives
    // must refer to an output port or an internal net that drives one or more module outputs.
    pulsestyle_onevent data_in;

    // STX_VE_417 Violation 2: 'internal_signal' is an internal net that does not
    // drive any module output. Therefore, it is not a valid output-path for pulsestyle directives.
    pulsestyle_ondetect internal_signal;
  endspecify

endmodule

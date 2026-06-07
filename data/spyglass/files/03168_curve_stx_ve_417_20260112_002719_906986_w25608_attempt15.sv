module curve_stx_ve_417_20260112_002719_906986_w25608_attempt15 (
    input clk,
    input rst_n,
    input d_in,
    output reg q_out
);

  // Simple sequential logic to use all inputs and drive the output,
  // preventing potential unused signal or undriven output warnings.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_out <= 1'b0;
    end else begin
      q_out <= d_in;
    end
  end

  specify
    // STX_VE_417 violation: 'rst_n' is an input port.
    // According to Verilog LRM 1364-2001, section 14.6.1,
    // pulsestyle directives must refer to an 'output-path'.
    // An output-path is defined as an output port or an internal net
    // that drives one or more module outputs. An input port is not a valid output-path.
    pulsestyle_onevent rst_n;

    // Path delays are included to satisfy the syntax requirements of a specify block
    // and prevent a SYNTH_92 warning (Specify block has no path delay).
    (clk => q_out) = (1, 1);
    (d_in => q_out) = (1, 1);
  endspecify

endmodule

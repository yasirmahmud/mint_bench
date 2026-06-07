module curve_stx_ve_417_20260112_002719_906986_w25608_attempt14 (
    input clk,
    input reset,
    output reg q_out
);

  // Simple sequential logic to ensure inputs/outputs are used and driven,
  // preventing potential unused signal or undriven output warnings.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_out <= 1'b0;
    end else begin
      q_out <= ~q_out;
    end
  end

  specify
    // STX_VE_417 violation 1: 'clk' is an input port. According to Verilog LRM 1364-2001,
    // section 14.6.1, pulsestyle directives must refer to an output-path (output port
    // or an internal net driving an output). An input port is not a valid output-path.
    pulsestyle_onevent clk;

    // STX_VE_417 violation 2: 'reset' is an input port. Similar to 'clk', inputs are
    // not valid output-paths for pulsestyle directives.
    pulsestyle_ondetect reset;
  endspecify

endmodule

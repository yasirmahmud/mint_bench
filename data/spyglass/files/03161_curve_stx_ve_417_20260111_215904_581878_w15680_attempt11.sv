module curve_stx_ve_417_20260111_215904_581878_w15680_attempt11 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  // Simple combinational logic to ensure ports are used and avoid unused signal warnings
  always @(posedge clk) begin
    data_out <= data_in;
  end

  specify
    // STX_VE_417 violation: 'data_in' is an input port. According to Verilog LRM 1364-2001,
    // section 14.6.1, pulsestyle directives must refer to an output-path, not an input.
    pulsestyle_onevent data_in;

    // A valid path delay from input to output to prevent additional violations like SYNTH_92
    // and ensure the specify block is otherwise syntactically correct.
    (data_in => data_out) = (1, 2);
  endspecify

endmodule

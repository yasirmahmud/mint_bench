module curve_stx_ve_416_20260111_235528_570371_w47152_attempt13 (
  input wire in_data,
  output reg out_data
);

  // Internal wire that will be incorrectly used as an input path in the specify block.
  wire internal_signal_for_path_delay;

  // Simple combinational logic to ensure signals are used.
  assign internal_signal_for_path_delay = in_data;

  always @(*) begin
    out_data = internal_signal_for_path_delay;
  end

  // Specify block to define path delays.
  specify
    // STX_VE_416 violation: 'internal_signal_for_path_delay' is an internal wire,
    // not an input or inout port. Therefore, it is not a valid input-path terminal
    // for a specify block path delay statement.
    (internal_signal_for_path_delay => out_data) = 1;
  endspecify

endmodule

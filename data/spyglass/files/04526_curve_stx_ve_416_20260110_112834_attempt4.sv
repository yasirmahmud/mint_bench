module curve_stx_ve_416_20260110_112834_attempt4 (
  input clk_i,
  input rst_ni,
  output out_q
);
  reg internal_sig; // An internal 'reg' signal, not an input/inout port.

  // Drive 'internal_sig' in a synthesizable manner to avoid unused signal violations.
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      internal_sig <= 1'b0;
    end else begin
      internal_sig <= ~internal_sig;
    end
  end

  // Connect 'internal_sig' to 'out_q' to avoid unused signal violations for 'out_q' and 'internal_sig'.
  assign out_q = internal_sig;

  specify
    // STX_VE_416: 'internal_sig' is an internal 'reg', which is not a valid input-path for a specify block.
    // 'out_q' is a valid output port, so STX_VE_418 (invalid output path) is avoided.
    (internal_sig => out_q) = 1; 
  endspecify
endmodule

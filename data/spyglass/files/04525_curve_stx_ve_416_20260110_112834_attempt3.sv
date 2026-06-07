module curve_stx_ve_416_20260110_112834_attempt3 (
  input clk_i,
  input rst_ni,
  output out_q
);
  reg internal_sig; // This 'reg' will be used as the invalid input path.

  // Simple sequential logic to use 'internal_sig' and make it synthesizable
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      internal_sig <= 1'b0;
    end else begin
      internal_sig <= ~internal_sig;
    end
  end

  // Connect 'internal_sig' to 'out_q' to avoid unused signal warnings for out_q and internal_sig.
  assign out_q = internal_sig;

  specify
    // STX_VE_416: 'internal_sig' (an internal 'reg') is not a valid input-path for a specify block.
    // 'out_q' (an output port) is a valid output-path, so STX_VE_418 should not be triggered.
    (internal_sig => out_q) = 1;
  endspecify
endmodule

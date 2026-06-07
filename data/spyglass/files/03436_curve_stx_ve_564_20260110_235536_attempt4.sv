module curve_stx_ve_564_20260110_235536_attempt4 (
  input wire [7:0] data_in,
  input wire clk,
  output reg [7:0] data_out
);

  // Define a function, intentionally missing 'endfunction'
  function [7:0] compute_hash_segment (input [7:0] segment_val);
    compute_hash_segment = ~segment_val + 8'd7; // Some simple logic
    // FATAL VIOLATION: Keyword 'endfunction' is missing here.
    // SpyGlass rule STX_VE_564 is expected to trigger at this point.

  // Declare an always block after the incomplete function definition
  // to make this example distinct from previous attempts.
  // This block would normally be valid, but the missing 'endfunction' above
  // will cause a syntax error before this block is properly parsed.
  always @(posedge clk) begin
    data_out <= data_in; // Simple sequential assignment to avoid unused port
  end

endmodule

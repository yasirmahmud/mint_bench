module curve_synth_5317_20260112_001825_786647_w44756_attempt18 (
  input wire clk,
  input wire enable_in,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // SYNTH_5317: Always block that has both a timing control statement
  // as well as embedded event (@) expression is not supported by synthesis.
  always @(enable_in) begin
    // Violation: Embedded event control (@(posedge clk)) is used on the RHS
    // of a blocking assignment within an always block that is sensitive
    // to a different signal (enable_in). This construct is unsynthesizable.
    data_out = @(posedge clk) data_in;
  end

endmodule

module curve_synth_5317_20260112_001825_786647_w44756_attempt17 (
  input wire clk,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // SYNTH_5317: Always block that has both a timing control statement
  // as well as embedded event (@) expression is not supported by synthesis.
  // This construct is considered non-synthesizable.
  always @(*) begin
    // Violation: Embedded event control (@(posedge clk)) on the RHS
    // of a non-blocking assignment within an always block that is not
    // itself an explicit sequential block (e.g., sensitive to posedge clk).
    data_out <= @(posedge clk) data_in;
  end

endmodule

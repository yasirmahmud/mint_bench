module curve_synth_5188_20260110_173530_attempt13 (
  input clk,
  input rst_n, // Asynchronous reset
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // Target rule: SYNTH_5188
  // Rule description: Invalid placement of event control statement inside asynchronous implicit style always block. Not supported.
  // This module is designed to trigger SYNTH_5188 exactly once.
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'b0; // Asynchronous reset
    end else begin
      // This line triggers SYNTH_5188. An event control (@(posedge clk))
      // is used on the RHS of a non-blocking assignment within an 'always' block
      // that has an asynchronous sensitivity list (posedge clk or negedge rst_n).
      data_out <= @(posedge clk) data_in;
    end
  end

endmodule

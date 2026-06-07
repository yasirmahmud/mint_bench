module curve_mixedsenselist_20260111_081304_attempt5 (
    input wire clk,
    input wire control_signal,
    input wire data_in,
    output reg data_out
);

  // This 'always' block is specifically designed to trigger the 'mixedsenselist' violation.
  // It contains both an edge-sensitive event (posedge clk) and a level-sensitive
  // event (control_signal) in its sensitivity list. This combination makes the block's
  // behavior ambiguous for unsynthesizable as it mixes sequential (clock edge) and
  // combinational (level-sensitive signal) triggering, which is generally not synthesizable.
  always @(posedge clk or control_signal) begin
    if (control_signal) begin
      data_out <= data_in;
    end else begin
      data_out <= 1'b0;
    end
  end

endmodule

module curve_mixedsenselist_20260111_081304_attempt3 (
    input clk,
    input async_clear,
    input data_in,
    output reg out_data
);

  // This 'always' block has a mixed sensitivity list.
  // 'posedge clk' is an edge-sensitive event, and 'async_clear' is a level-sensitive event.
  // This combination is typically flagged by synthesis tools as problematic or unsynthesizable,
  // triggering the 'mixedsenselist' violation.
  always @(posedge clk or async_clear) begin
    if (async_clear) begin // Level-sensitive reset
      out_data <= 1'b0;
    end else begin
      out_data <= data_in; // Clocked data capture
    end
  end

endmodule

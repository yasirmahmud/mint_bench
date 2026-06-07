module curve_mixedsenselist_20260111_081304_attempt2 (
    input clock,
    input data_in,
    input enable,
    output reg out_data
);

  // This 'always' block has a mixed sensitivity list.
  // 'negedge clock' is an edge-sensitive event, and 'enable' is a level-sensitive event.
  // This combination is typically flagged by synthesis tools as problematic or unsynthesizable,
  // triggering the 'mixedsenselist' violation.
  always @(negedge clock or enable) begin
    if (enable) begin
      out_data <= data_in;
    end else begin
      out_data <= 1'b0;
    end
  end

endmodule

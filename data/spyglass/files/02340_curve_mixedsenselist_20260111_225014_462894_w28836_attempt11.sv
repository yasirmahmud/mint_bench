module curve_mixedsenselist_20260111_225014_462894_w28836_attempt11 (
  input clock,
  input async_set,
  input data_in,
  output reg data_out
);

  // This 'always' block demonstrates a 'mixedsenselist' violation because its sensitivity list
  // includes both an edge-sensitive event (posedge clock) and a level-sensitive event (async_set).
  // This ambiguity in defining hardware behavior (partially sequential, partially combinational/asynchronous)
  // is flagged as non-synthesizable or problematic by synthesis tools.
  always @(posedge clock or async_set) begin
    if (async_set) begin // Asynchronous set condition
      data_out <= 1'b1;
    end else begin // Synchronous data capture on clock edge
      data_out <= data_in;
    end
  end

endmodule

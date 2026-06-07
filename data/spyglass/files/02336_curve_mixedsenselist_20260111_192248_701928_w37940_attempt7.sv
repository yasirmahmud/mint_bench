module curve_mixedsenselist_20260111_192248_701928_w37940_attempt7 (
  input clk,
  input data_in,
  input enable_async, // Used as a level-sensitive signal in the sensitivity list
  output reg data_out
);

  // This always block triggers a 'mixedsenselist' violation because its sensitivity list
  // contains both an edge-sensitive condition (posedge clk) and a level-sensitive
  // condition (enable_async). Mixing these types of conditions is non-synthesizable
  // or leads to ambiguous hardware interpretation by synthesis tools.
  always @(posedge clk or enable_async) begin
    if (enable_async) begin
      // When enable_async is high, capture data on the positive edge of clk.
      data_out <= data_in;
    end else begin
      // When enable_async is low, explicitly clear data_out.
      // The 'mixedsenselist' violation is due to the sensitivity list, not the logic itself.
      data_out <= 1'b0;
    end
  end

endmodule

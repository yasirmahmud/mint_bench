module undriven_signal_in_property_1 (
  input clk,
  input rst
);

  logic data_valid;

  // Drive data_valid to resolve the PRP_NO_DRNC warning and utilize clk/rst inputs.
  // This ensures data_valid is a driven signal and removes W240 warnings for clk/rst.
  always_ff @(posedge clk or posedge rst) begin
    if (rst) {
      data_valid <= 1'b0; // Reset data_valid to a known state
    } else {
      data_valid <= ~data_valid; // Example: toggle data_valid every clock cycle
    }
  end

endmodule

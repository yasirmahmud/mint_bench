module curve_w122_20260111_144513_attempt4 (
  input wire update_en,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // This is a level-sensitive always block that infers a latch.
  // When 'update_en' is high, 'data_out' takes the value of 'data_in'.
  // When 'update_en' is low, 'data_out' holds its current value (latch behavior).
  // The sensitivity list now correctly includes only signals that cause a change in output
  // or that enable/disable the data flow (update_en, data_in).
  // The explicit self-assignment 'data_out <= data_out;' has been removed,
  // relying on Verilog's implicit latch inference for unassigned 'reg' in conditional blocks.
  // Using blocking assignment for latch inference is standard practice.
  always @(update_en or data_in) begin
    if (update_en) begin
      data_out = data_in; // Blocking assignment for latch inference
    end
    // else: data_out is not assigned, inferring a latch that holds its value
  end

endmodule

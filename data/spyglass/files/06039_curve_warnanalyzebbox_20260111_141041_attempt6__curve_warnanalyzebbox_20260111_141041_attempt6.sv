// This is the top-level module for the example.
// It instantiates 'my_black_box' and ensures that all its own signals are properly used
// and driven to avoid triggering any secondary linting violations.
module curve_warnanalyzebbox_20260111_141041_attempt6 (
  input         clk,      // Clock signal
  input         rst_n,    // Active-low reset signal
  input         data_in,  // Input data for the top-level module
  output  reg   data_out  // Output data from the top-level module
);

  // Internal wire to connect the output of the black box to the top-level logic.
  // This ensures 'box_out' is connected and 'internal_signal' is used.
  wire internal_signal;

  // Instantiate the 'my_black_box' module.
  // Its inputs are driven by 'data_in', and its outputs drive 'internal_signal'.
  my_black_box u_my_black_box_instance (
    .box_in  (data_in),
    .box_out (internal_signal)
  );

  // A simple synchronous register to demonstrate proper usage of top-level inputs
  // and to drive the output, preventing 'unused signal' or 'output not driven' warnings.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0; // Reset path: 'rst_n' is used.
    end else begin
      data_out <= internal_signal; // Data path: 'clk' and 'internal_signal' are used.
    end
  end

endmodule // curve_warnanalyzebbox_20260111_141041_attempt6

// This is the top-level module for the example.
// It instantiates 'my_black_box' and ensures that all its own signals are properly used
// and driven to avoid triggering any secondary linting violations.
module curve_warnanalyzebbox_20260111_141041_attempt7 (
  input         clk,      // Clock signal, used in always block
  input         rst_n,    // Active-low reset signal, used in always block
  input         data_in,  // Input data for the top-level module, used to drive output
  output  reg   data_out  // Output data from the top-level module, driven by data_in
);

  // Instantiate the 'my_black_box' module.
  // Since it has no ports, the instantiation is simple and requires no connections.
  my_black_box u_my_black_box_instance ();

  // A simple synchronous register to demonstrate proper usage of top-level inputs
  // and to drive the output, preventing 'unused signal' or 'output not driven' warnings.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0; // Reset path: 'rst_n' is used, 'data_out' is driven.
    end else begin
      data_out <= data_in; // Data path: 'clk' is used, 'data_in' is used.
    end
  }

endmodule // curve_warnanalyzebbox_20260111_141041_attempt7

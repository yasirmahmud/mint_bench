// The top-level module that instantiates the 'empty_sub_module'.
// This module is carefully constructed to avoid all other common violations
// like W240 (unused signals), latches, multiple drivers, etc.
module curve_warnanalyzebbox_20260111_141041_attempt2 (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output [7:0] data_out
);

  // Wires for connecting to the sub-module instance
  wire sub_mod_input_sig;
  wire sub_mod_output_sig;

  // Instantiate the empty_sub_module
  empty_sub_module u_empty_instance (
    .in_val  (sub_mod_input_sig),
    .out_val (sub_mod_output_sig)
  );

  // Internal register to pipeline data and use all top-level inputs.
  // This avoids W240 warnings for clk, rst_n, and data_in.
  reg [7:0] data_pipeline_reg;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_pipeline_reg <= 8'h00;
    end else begin
      data_pipeline_reg <= data_in; // Uses data_in, clk, rst_n
    end
  end

  // Drive the top-level output
  assign data_out = data_pipeline_reg;

  // Drive the sub-module's input and use its output to avoid W240 for local wires.
  // 'clk' is used again here, which is acceptable.
  assign sub_mod_input_sig = clk;

  // Use the output of the sub-module to prevent W240 on 'sub_mod_output_sig'.
  reg dummy_sub_output_sink;
  always @(posedge clk) begin
    dummy_sub_output_sink <= sub_mod_output_sig; // Uses clk, sub_mod_output_sig
  end

endmodule

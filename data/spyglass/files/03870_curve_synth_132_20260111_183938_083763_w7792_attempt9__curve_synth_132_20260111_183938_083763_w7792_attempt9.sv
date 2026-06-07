module curve_synth_132_20260111_183938_083763_w7792_attempt9 (
  input wire clk,
  input wire rst_n,
  output wire [7:0] data_out
);

  wire sub_module_data_out; // Declare the wire for sub_module's output

  // Instantiate the sub-module
  sub_module u_sub_inst (
    .clk_i    (clk),
    .data_o   (sub_module_data_out)
  );

  // SYNTH_132 Violation: Hierarchical reference used in a localparam definition.
  // Synthesis tools typically do not support hierarchical references for constant expressions
  // that determine structural properties or sizes, like a parameter from an instantiated module.
  localparam TOP_WIDTH = u_sub_inst.WIDTH_PARAM + 4; // Expected violation here

  reg [TOP_WIDTH-1:0] counter_main;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_main <= {TOP_WIDTH{1'b0}};
    end else begin
      // Use 'sub_module_data_out' to avoid unused wire warning and keep logic active.
      // The actual functionality is not critical, just its usage.
      counter_main <= counter_main + (sub_module_data_out ? 1 : 0);
    end
  end

  assign data_out = counter_main[7:0]; // Use counter_main, and data_out

endmodule

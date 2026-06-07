// This is the top-level module definition.
module curve_synth_132_20260112_012729_108752_w25608_attempt13 (
  input clk,
  input rst_n,
  input [15:0] input_data,
  output [15:0] output_data
);

  // Instantiate the sub-module, overriding the CHANNEL_WIDTH parameter
  data_processor #(.CHANNEL_WIDTH(16)) u_data_proc (
    .clk(clk),
    .rst_n(rst_n),
    .din(input_data),
    .dout(output_data) // Connect sub-module output directly to top-module output
  );

  // SYNTH_132 Violation: This localparam declaration uses a hierarchical reference
  // (u_data_proc.CHANNEL_WIDTH) to a parameter of an instantiated module.
  // Synthesis tools generally do not support hierarchical references in constant expressions
  // like localparam declarations, leading to a SYNTH_132 violation.
  localparam TOTAL_DATA_BUS_WIDTH = u_data_proc.CHANNEL_WIDTH * 2; // Expected SYNTH_132 violation

  // Declare an internal register using the problematic localparam to ensure its use
  // and avoid potential unused parameter warnings for TOTAL_DATA_BUS_WIDTH itself.
  reg [TOTAL_DATA_BUS_WIDTH-1:0] internal_pipeline_reg;

  always @(posedge clk) begin
    if (!rst_n) begin
      internal_pipeline_reg <= {TOTAL_DATA_BUS_WIDTH{1'b0}};
    end else begin
      internal_pipeline_reg <= {{(TOTAL_DATA_BUS_WIDTH-1){1'b0}}, 1'b1}; // Dummy data assignment
    end
  end

endmodule

// This is the top-level module designed to trigger SYNTH_132.
module curve_synth_132_20260112_012729_108752_w25608_attempt15 (
  input clk,
  input rst_n,
  input [7:0] input_main_data,
  output [7:0] output_sub_data,
  output [7:0] output_derived_data
);

  // Instantiate the sub-module with a specific DATA_SIZE.
  // This instance will have DATA_SIZE set to 8.
  param_module #(.DATA_SIZE(8)) u_param_inst (
    .clk(clk),
    .rst_n(rst_n),
    .din(input_main_data),
    .dout(output_sub_data)
  );

  // SYNTH_132 Violation: This localparam declaration uses a hierarchical reference
  // (u_param_inst.DATA_SIZE) to a parameter of an instantiated module.
  // Synthesis tools generally do not support hierarchical references in constant
  // expressions that define design properties or sizes, leading to SYNTH_132.
  localparam DERIVED_DATA_SIZE = u_param_inst.DATA_SIZE * 2; // This line triggers SYNTH_132

  // Declare an internal register whose width depends on the problematic localparam.
  reg [DERIVED_DATA_SIZE-1:0] internal_data_storage;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_data_storage <= {DERIVED_DATA_SIZE{1'b0}};
    end else begin
      // Assign data to internal_data_storage to ensure it's written.
      // Input data is 8-bit, so concatenate it to match the 16-bit DERIVED_DATA_SIZE.
      internal_data_storage <= {input_main_data, input_main_data};
    end
  end

  // Drive an output with a portion of internal_data_storage to ensure it is read
  // and avoid the W528 warning (variable set but not read).
  assign output_derived_data = internal_data_storage[7:0];

endmodule

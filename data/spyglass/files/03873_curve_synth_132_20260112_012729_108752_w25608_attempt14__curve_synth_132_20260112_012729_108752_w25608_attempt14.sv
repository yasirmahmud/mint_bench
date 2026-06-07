// This is the top-level module designed to trigger SYNTH_132.
module curve_synth_132_20260112_012729_108752_w25608_attempt14 (
  input clk,
  input rst_n,
  input [7:0] input_data,
  output [7:0] output_data
);

  // Instantiate the sub-module. We set DATA_WIDTH to 8 for the instance.
  data_processor #(.DATA_WIDTH(8)) u_data_proc (
    .clk(clk),
    .rst_n(rst_n),
    .din(input_data),
    .dout(output_data)
  );

  // SYNTH_132 Violation: This localparam declaration uses a hierarchical reference
  // (u_data_proc.DATA_WIDTH) to a parameter of an instantiated module. 
  // Synthesis tools generally do not support hierarchical references in constant 
  // expressions like localparam declarations for deriving design structural properties.
  localparam SCALED_WIDTH = u_data_proc.DATA_WIDTH * 2; // This line triggers SYNTH_132

  // Declare an internal register whose width depends on the problematic localparam
  // to ensure its use and avoid potential unused parameter warnings for SCALED_WIDTH itself.
  reg [SCALED_WIDTH-1:0] internal_register;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_register <= {SCALED_WIDTH{1'b0}};
    end else begin
      // Assign data to internal_register to ensure it's used and avoid unused signal warnings.
      // The concatenation ensures the width matches SCALED_WIDTH (8*2 = 16 bits).
      internal_register <= {input_data, input_data};
    end
  end

endmodule

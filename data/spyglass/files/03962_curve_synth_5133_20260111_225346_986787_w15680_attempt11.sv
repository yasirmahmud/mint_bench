module synth_5133_example_8 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] internal_driver_data,
  input wire [3:0] external_input_data,
  input wire [3:0] violating_input_port,
  output reg [3:0] module_output_val
);

  // SYNTH_5133: Input port 'violating_input_port' is being continuously driven
  // This line drives an input port from within the module, triggering SYNTH_5133.
  assign violating_input_port = internal_driver_data;

  // Logic to use other inputs and drive the output to avoid unused signal warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output_val <= 4'b0;
    end else begin
      // Use another input 'external_input_data' to drive the output
      module_output_val <= external_input_data + 1;
    end
  end

endmodule

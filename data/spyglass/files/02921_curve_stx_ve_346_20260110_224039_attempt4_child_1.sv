module curve_stx_ve_346_20260110_224039_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_data_port_a,
  input wire [7:0] input_data_port_b,
  output reg [7:0] module_output_reg_port
);

  // Function with an internal temporary 'reg' variable instead of an 'output reg' argument
  // This resolves STX_VE_346 by not attempting to procedurally assign to a net type (input_data_port_a).
  // The functional behavior of the module's output (module_output_reg_port) is preserved
  // as it effectively computes (input_data_port_b + 1) * 2.
  function [7:0] my_processing_function;
    input  [7:0]     func_input_arg;    // Formal input argument
    reg    [7:0]     func_intermediate_reg; // Local temporary reg for computation
    begin
      func_intermediate_reg = func_input_arg + 1; // This procedural assignment now drives a local reg
      my_processing_function = func_intermediate_reg * 2; // Function return value
    end
  endfunction

  // Declare a wire to hold the function's return value
  wire [7:0] func_return_value_wire;

  // The call is updated to only pass the input_data_port_b, as input_data_port_a was incorrectly
  // passed as an output argument and its value was not used in the calculation, but rather
  // was meant to be overwritten (which caused the violation).
  assign func_return_value_wire = my_processing_function(input_data_port_b); // Fixed: Removed input_data_port_a from output argument position

  // Use all signals to avoid unused warnings
  // Note: input_data_port_a is now genuinely unused in the functional path to module_output_reg_port.
  // This reveals the original design intent of input_data_port_a being extraneous to this calculation.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output_reg_port <= 8'h00;
    end else begin
      module_output_reg_port <= func_return_value_wire;
    end
  end

endmodule

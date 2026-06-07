module curve_stx_ve_346_20260110_224039_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_data_port_a, // This input port (a net type) will cause the violation
  input wire [7:0] input_data_port_b,
  output reg [7:0] module_output_reg_port
);

  // Function with a formal 'output reg' argument
  function [7:0] my_processing_function;
    output reg [7:0] func_output_arg; // Formal output argument, type 'reg'
    input  [7:0]     func_input_arg;    // Formal input argument
    begin
      func_output_arg = func_input_arg + 1; // This procedural assignment will attempt to drive the actual argument
      my_processing_function = func_output_arg * 2; // Function return value
    end
  endfunction

  // Declare a wire to hold the function's return value
  wire [7:0] func_return_value_wire;

  // Trigger STX_VE_346: Invalid argument ( input_data_port_a ) to function ( my_processing_function ) ( output )
  // 'input_data_port_a' is an 'input wire' port. It is a net type and cannot be assigned to
  // by a procedural assignment within the function via its formal 'output reg' argument (func_output_arg).
  // Verilog-2001 requires actual arguments corresponding to formal 'output reg' function arguments
  // to be a variable type (like 'reg') or an output port declared as 'reg'.
  assign func_return_value_wire = my_processing_function(input_data_port_a, input_data_port_b); // Violation line

  // Use all signals to avoid unused warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output_reg_port <= 8'h00;
    end else begin
      module_output_reg_port <= func_return_value_wire;
    end
  end

endmodule

module curve_stx_ve_346_20260110_224039_attempt2 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_to_function_output, // This will be the problematic argument
  input wire [7:0] input_to_function_input,
  output reg [7:0] data_out
);

  // Function with an 'output' formal argument
  // In Verilog-2001, output function arguments must be declared as 'reg' type.
  function [7:0] my_func_with_output_arg;
    output reg [7:0] func_out_val; // Formal output argument
    input  [7:0]     func_in_val;  // Formal input argument
    begin
      func_out_val = func_in_val + 1; // Assign to the output argument
      my_func_with_output_arg = func_out_val * 2; // Function return value
    end
  endfunction

  // Intermediate wire to hold the function's return value
  wire [7:0] func_result_wire;
  
  // Trigger STX_VE_346: Invalid argument ( input_to_function_output ) to function ( my_func_with_output_arg ) ( output )
  // The actual argument 'input_to_function_output' is an 'input wire' port.
  // An input port cannot be an lvalue (something that can be written to) in the calling context
  // when passed to a formal 'output reg' argument of a function. The function attempts to assign
  // a value to 'func_out_val', but 'input_to_function_output' is read-only.
  assign func_result_wire = my_func_with_output_arg(input_to_function_output, input_to_function_input); // Violation line

  // Use clk, rst_n, and func_result_wire to drive data_out (avoid unused signals)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_result_wire;
    end
  end

endmodule

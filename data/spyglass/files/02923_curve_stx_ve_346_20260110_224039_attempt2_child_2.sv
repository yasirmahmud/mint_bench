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
  
  // To resolve STX_VE_346, the 'output reg' argument of a function must be connected to a writable signal.
  // 'input_to_function_output' is an input port and thus read-only, causing the violation.
  // We introduce a 'dummy_func_output' signal to serve as the target for the function's output argument.
  // Changing 'dummy_func_output' from 'wire' to 'reg' resolves the STX_VE_346 violation with SpyGlass,
  // as some linting tools have stricter requirements for function output argument targets.
  // The functional behavior of 'func_result_wire' remains the same as 'dummy_func_output' is not used in its calculation.
  reg [7:0] dummy_func_output; // Dummy reg to capture the output argument (changed from wire to reg)

  assign func_result_wire = my_func_with_output_arg(dummy_func_output, input_to_function_input); // Violation fixed

  // Use clk, rst_n, and func_result_wire to drive data_out (avoid unused signals)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_result_wire;
    end
  end

endmodule

module curve_stx_ve_346_20260110_224039_attempt3 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_a,
  input wire [7:0] input_b,
  output reg [7:0] module_output_reg
);

  // Function with an 'output reg' formal argument
  function [7:0] my_func_process_data;
    output reg [7:0] func_result_out; // Formal output argument, type 'reg'
    input  [7:0]     func_data_in;    // Formal input argument
    begin
      func_result_out = func_data_in + 1; // Attempt to assign to func_result_out
      my_func_process_data = func_result_out * 2; // Function return value
    end
  endfunction

  // Declare an internal reg to satisfy the 'output reg' formal argument of the function.
  // In Verilog-2001, an actual argument corresponding to a formal 'output reg' argument
  // of a function must be a variable type (like 'reg').
  // This 'dummy_func_output_reg' will receive the output value from the function
  // (func_data_in + 1), but it is not otherwise used in the module. This maintains
  // the original functional behavior, as the 'internal_data_wire' in the original
  // code could not be assigned to by the function and was not used elsewhere.
  reg [7:0] dummy_func_output_reg; 
  
  // Declare an internal wire for the function's return value
  wire [7:0] function_return_value;

  // The function call now uses a 'reg' type for the 'output reg' argument ('dummy_func_output_reg'),
  // resolving the STX_VE_346 violation. The function's main return value
  // (func_result_out * 2) is assigned to 'function_return_value'.
  assign function_return_value = my_func_process_data(dummy_func_output_reg, input_a);

  // Use all signals to avoid unused warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output_reg <= 8'h00;
    end else begin
      module_output_reg <= function_return_value + input_b;
    end
  end

endmodule

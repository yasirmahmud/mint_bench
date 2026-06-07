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

  // Declare an internal wire (net type)
  wire [7:0] internal_data_wire; 
  wire [7:0] function_return_value;

  // Trigger STX_VE_346: Invalid argument ( internal_data_wire ) to function ( my_func_process_data ) ( output )
  // 'internal_data_wire' is a 'wire' type (net). In Verilog-2001, an actual argument
  // corresponding to a formal 'output reg' argument of a function must be a variable type (like 'reg')
  // or an output port that can be assigned to procedurally. A 'wire' (net type) cannot be directly
  // assigned to by a procedural assignment within the function via its output port.
  assign function_return_value = my_func_process_data(internal_data_wire, input_a); // Violation line

  // Use all signals to avoid unused warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output_reg <= 8'h00;
    end else begin
      module_output_reg <= function_return_value + input_b;
    end
  end

endmodule

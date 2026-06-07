module curve_stx_ve_346_20260110_224039_attempt1 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Function with an 'output' formal argument
  // This formal argument 'func_out_val' must be declared as 'reg' type.
  function [7:0] my_func_with_output_arg;
    output reg [7:0] func_out_val; // This is the 'output' formal argument
    input  [7:0]     func_in_val;
    begin
      func_out_val = func_in_val + 1; // Assign to the output argument
      my_func_with_output_arg = func_out_val * 2; // Function return value
    end
  endfunction

  // Intermediate wire to hold the function's return value
  wire [7:0] func_result_wire;
  
  // To resolve STX_VE_346, declare a 'reg' to serve as the actual argument
  // for the function's 'output reg' formal argument. While a 'wire' is technically
  // allowed by the Verilog LRM for 'output' arguments, some linting tools
  // (like SpyGlass for STX_VE_346 with 'output reg' formal) might prefer
  // a 'reg' actual argument for stricter type compatibility.
  reg [7:0] dummy_func_output_arg;

  // STX_VE_346 violation resolved by changing 'dummy_func_output_arg' from 'wire' to 'reg'.
  // The original violation was triggered because 'func_out_val' is declared as 'output reg',
  // and SpyGlass indicated an invalid argument when a 'wire' was passed, suggesting a
  // stricter type matching for 'output reg' formal arguments.
  assign func_result_wire = my_func_with_output_arg(dummy_func_output_arg, data_in);

  // Use clk, rst_n, and func_result_wire to drive data_out (avoid unused signals)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_result_wire;
    end
  end

endmodule

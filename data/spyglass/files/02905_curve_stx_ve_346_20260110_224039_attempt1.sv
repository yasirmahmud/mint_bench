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
  
  // Trigger STX_VE_346: Invalid argument ( actual_output ) to function ( my_func ) ( output )
  // The 'actual_output' here is the constant '8'd5', which is invalid
  // when passed to 'func_out_val' (an 'output' formal argument). This is because
  // 'output' function arguments must be assigned to, and a constant is not an lvalue
  // (something that can be written to).
  assign func_result_wire = my_func_with_output_arg(8'd5, data_in); // Violation line

  // Use clk, rst_n, and func_result_wire to drive data_out (avoid unused signals)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_result_wire;
    end
  end

endmodule

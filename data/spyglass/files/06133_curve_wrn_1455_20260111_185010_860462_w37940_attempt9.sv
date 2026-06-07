module curve_wrn_1455_20260111_185010_860462_w37940_attempt9 (
  input wire [3:0] input_data,
  output reg [3:0] output_data
);

  // Define a function that returns a 4-bit value (non-void return type).
  function [3:0] compute_result (input [3:0] input_val);
    begin
      compute_result = input_val + 2;
    end
  endfunction

  always @(*) begin
    // Dummy assignment to keep output port 'output_data' used and prevent latches.
    output_data = input_data;

    // WRN_1455: This line triggers the violation.
    // 'compute_result' has a non-void return type ([3:0]), but its return value
    // is not assigned to a variable, used in an expression, or passed as
    // an argument to another function. This is an "invalid void function call".
    compute_result(input_data);
  end

endmodule

module curve_wrn_1455_20260111_223437_371195_w28836_attempt12 (
  input wire [7:0] input_a,
  input wire [7:0] input_b,
  output reg        out_state
);

  // Function with a non-void return type (reg [15:0])
  function [15:0] compute_sum;
    input [7:0] val1;
    input [7:0] val2;
    begin
      compute_sum = val1 + val2;
    end
  endfunction

  always @(*) begin
    out_state = 1'b0; // Assign to a dummy output to prevent unused output warnings or latch inference

    // WRN_1455 will be triggered here because the return value of 'compute_sum'
    // is not assigned to a variable, used in an expression, or passed as an argument.
    compute_sum(input_a, input_b);
  end

endmodule

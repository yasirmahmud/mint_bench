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
      // W416 fix: Explicitly widen operands to 16 bits before addition
      // to ensure the sum is computed and assigned with the full 16-bit width,
      // matching the function's return type and resolving the width mismatch warning.
      compute_sum = {8'b0, val1} + {8'b0, val2};
    end
  endfunction

  always @(*) begin
    out_state = 1'b0; // Assign to a dummy output to prevent unused output warnings or latch inference

    // WRN_1455 fix: The return value of 'compute_sum' was not used.
    // To preserve the functional behavior (which was to effectively do nothing with the sum),
    // the call to the function is removed as it is dead code without side effects.
    // compute_sum(input_a, input_b); // Original line causing WRN_1455
  end

endmodule

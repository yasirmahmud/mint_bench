module curve_wrn_1455_20260111_223437_371195_w28836_attempt11 (
  input wire [7:0] in_data,
  input wire [2:0] in_shift_amount,
  output reg        out_dummy
);

  // Function with a non-void return type (reg [7:0])
  function [7:0] calculate_shifted_value;
    input [7:0] value_in;
    input [2:0] shift_by;
    begin
      calculate_shifted_value = value_in << shift_by;
    end
  endfunction

  // The 'dummy_shifted_value' register is removed as its purpose can be integrated
  // directly into the 'out_dummy' assignment, resolving W528.

  always @(*) begin
    // Assign the return value of 'calculate_shifted_value' to a dummy output.
    // Slicing and ANDing with 1'b0 ensures 'out_dummy' remains 0,
    // preserving functional behavior while consuming the function's return value.
    // This resolves the implicit WRN_1455 (function return value used) and W528
    // (unused variable 'dummy_shifted_value' is no longer needed).
    out_dummy = calculate_shifted_value(in_data, in_shift_amount)[0] & 1'b0;
  end

endmodule

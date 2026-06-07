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

  // Declare a dummy register to store the function's return value
  // This resolves WRN_1455 by ensuring the return value is assigned.
  reg [7:0] dummy_shifted_value;

  always @(*) begin
    out_dummy = 1'b0; // Assign to a dummy output to prevent unused output warnings

    // Assign the return value of 'calculate_shifted_value' to a dummy variable
    // This prevents WRN_1455 as the return value is now explicitly used (assigned).
    dummy_shifted_value = calculate_shifted_value(in_data, in_shift_amount);
  end

endmodule

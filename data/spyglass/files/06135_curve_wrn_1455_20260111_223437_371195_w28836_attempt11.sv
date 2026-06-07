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

  always @(*) begin
    out_dummy = 1'b0; // Assign to a dummy output to prevent unused output warnings

    // WRN_1455 will be triggered here because the return value of 'calculate_shifted_value'
    // is not assigned to a variable, used in an expression, or passed as an argument.
    calculate_shifted_value(in_data, in_shift_amount);
  end

endmodule

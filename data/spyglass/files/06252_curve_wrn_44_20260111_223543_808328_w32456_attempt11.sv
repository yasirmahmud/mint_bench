module curve_wrn_44_20260111_223543_808328_w32456_attempt11 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // This function definition will trigger WRN_44
  // due to the non-blocking assignment (<=) within its body.
  function [7:0] calculate_adjusted_value;
    input [7:0] func_operand;
    begin
      // WRN_44: Non-blocking assignment statements in a function
      // are not supported by Verilog-2001/2005 standards and may
      // lead to simulation mismatches or synthesis issues.
      calculate_adjusted_value <= func_operand + 8'd10;
    end
  endfunction

  always @* begin
    data_out = calculate_adjusted_value(data_in);
  end

endmodule

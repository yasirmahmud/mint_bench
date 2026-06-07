module curve_wrn_44_20260111_223543_808328_w32456_attempt12 (
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // This function definition will trigger WRN_44 due to the non-blocking assignment (<=) within its body.
  function [7:0] func_operation;
    input [7:0] operand;
    begin
      // WRN_44: Non-blocking assignment statements in a function
      // are not supported by Verilog-2001/2005 standards and may
      // lead to simulation mismatches or synthesis issues.
      func_operation <= operand + 8'h1; // Non-blocking assignment to the function's return value
    end
  endfunction

  always @* begin
    out_data = func_operation(in_data);
  end

endmodule

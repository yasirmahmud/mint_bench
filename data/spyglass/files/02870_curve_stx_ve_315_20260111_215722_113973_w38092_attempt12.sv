module curve_stx_ve_315_20260111_215722_113973_w38092_attempt12 (
  input wire [7:0] in_val_a,
  input wire [7:0] in_val_b,
  input wire       select_op,
  output wire [7:0] out_res
);

  // Define a non-void function that returns an 8-bit value
  function [7:0] calculate_and_return_val;
    input [7:0] p_val_x;
    input [7:0] p_val_y;
    input       p_select;
    reg [7:0] intermediate_result;
  begin
    intermediate_result = p_val_x + p_val_y; // Perform an initial calculation

    if (p_select == 1'b1) begin
      calculate_and_return_val = intermediate_result; // Assign function's return value
      return; // STX_VE_315 Trigger 1: 'return;' without a value expression
    end

    // Introduce a separate conditional path for the second violation
    if (p_val_x > p_val_y) begin
      calculate_and_return_val = p_val_x - p_val_y; // Assign function's return value
      return; // STX_VE_315 Trigger 2: 'return;' without a value expression
    end

    // A default assignment if neither of the above conditions lead to a return,
    // ensuring the function always has a value in simulation,
    // but the bare 'return;' statements are still flagged by the linter.
    calculate_and_return_val = p_val_x;

  end
  endfunction

  assign out_res = calculate_and_return_val(in_val_a, in_val_b, select_op);

endmodule

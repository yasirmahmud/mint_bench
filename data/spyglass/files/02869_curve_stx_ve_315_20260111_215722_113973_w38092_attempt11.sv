module curve_stx_ve_315_20260111_215722_113973_w38092_attempt11 (
  input wire [7:0] in_data,
  input wire       control_flag,
  output wire [7:0] result_out
);

  // Define a non-void function that returns an 8-bit value
  function [7:0] my_custom_function;
    input [7:0] param_val;
    input       param_ctrl;
    reg   [7:0] internal_calc_val; // Local variable for calculation

  begin
    if (param_ctrl == 1'b1) begin
      internal_calc_val = param_val + 8'd5;
      my_custom_function = internal_calc_val; // Assign function's return value
      return; // STX_VE_315 Trigger 1: 'return;' without a value expression
    end else begin
      internal_calc_val = param_val - 8'd5;
      my_custom_function = internal_calc_val; // Assign function's return value
      return; // STX_VE_315 Trigger 2: 'return;' without a value expression
    end
    // The function's return value 'my_custom_function' is explicitly set in all branches
    // before the bare 'return;' statement. Subsequent code in the function is unreachable.
  end
  endfunction

  assign result_out = my_custom_function(in_data, control_flag);

endmodule

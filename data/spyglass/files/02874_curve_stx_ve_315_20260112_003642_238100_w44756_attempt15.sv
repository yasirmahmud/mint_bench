module curve_stx_ve_315_20260112_003642_238100_w44756_attempt15 (
    input wire [3:0] in_a,
    input wire [3:0] in_b,
    input wire       control_flag,
    output wire [3:0] out_val
);

  // Define a non-void function that returns a 4-bit value
  function [3:0] calculate_sum_or_diff;
    input [3:0] val1;
    input [3:0] val2;
    input       mode_flag;
    reg [3:0]   intermediate_result;

    begin
      if (mode_flag == 1'b1) begin
        intermediate_result = val1 + val2;
        calculate_sum_or_diff = intermediate_result; // Assign the function's return value
        return; // STX_VE_315 Trigger 1: 'return;' without a value expression
      end else begin
        if (val1 > val2) begin
          intermediate_result = val1 - val2;
          calculate_sum_or_diff = intermediate_result; // Assign the function's return value
          return; // STX_VE_315 Trigger 2: 'return;' without a value expression
        end else begin
          calculate_sum_or_diff = val2 - val1; // Assign default return value if val1 <= val2
        end
      end
    end
  endfunction

  // Call the function and assign its result to the output port
  assign out_val = calculate_sum_or_diff(in_a, in_b, control_flag);

endmodule

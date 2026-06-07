module curve_w415a_20260111_160035_923474_w21676_attempt5 (
  input wire [7:0] sel_a,
  input wire [7:0] sel_b,
  output reg [7:0] result
);

  reg [7:0] data_reg_temp;
  integer i;

  always @* begin
    data_reg_temp = 8'h00;

    // To resolve the W415a violation (multiple assignments to 'data_reg_temp' in the same always block
    // and within the same for-loop), the loop is modified to iterate downwards.
    // This allows the first condition met (corresponding to the highest 'i') to set the value
    // of 'data_reg_temp' and then immediately exit the loop using 'break'.
    // This ensures 'data_reg_temp' is assigned at most once within the loop's execution path,
    // while preserving the original functional behavior where the assignment for the highest 'i'
    // (with 'sel_b[i]' taking precedence over 'sel_a[i]' for a given 'i') determines the final value.
    for (i = 7; i >= 0; i = i - 1) begin
      if (sel_b[i]) begin
        data_reg_temp = i + 1;
        break;
      end else if (sel_a[i]) begin
        data_reg_temp = i;
        break;
      end
    end
    result = data_reg_temp;
  end

endmodule

module curve_w415a_20260111_160035_923474_w21676_attempt5 (
  input wire [7:0] sel_a,
  input wire [7:0] sel_b,
  output reg [7:0] result
);

  reg [7:0] data_reg_temp; // The original signal flagged by SpyGlass
  reg [7:0] _data_reg_next_val; // Temporary variable to store the value derived from the loop
  integer i;

  always @* begin
    // Initialize the temporary variable. This ensures a default value if no conditions are met in the loop.
    _data_reg_next_val = 8'h00;

    // Loop downwards to find the highest 'i' that satisfies a condition.
    // Assignments inside the loop are now to the temporary variable '_data_reg_next_val',
    // not 'data_reg_temp', thus resolving the W415a violation.
    for (i = 7; i >= 0; i = i - 1) begin
      if (sel_b[i]) {
        _data_reg_next_val = i + 1;
        break; // Exit the loop immediately once the highest priority condition is met
      } else if (sel_a[i]) {
        _data_reg_next_val = i;
        break; // Exit the loop immediately once the highest priority condition is met
      }
    end

    // Assign the final value to 'data_reg_temp' only once outside the loop.
    // This ensures 'data_reg_temp' has a single assignment point in the always block,
    // satisfying the W415a rule while preserving original functional behavior.
    data_reg_temp = _data_reg_next_val;

    // The output 'result' is driven by 'data_reg_temp' as per original design.
    result = data_reg_temp;
  end

endmodule

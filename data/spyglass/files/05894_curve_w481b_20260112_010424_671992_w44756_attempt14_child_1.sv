module curve_w481b_20260112_010424_671992_w44756_attempt14 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  integer init_var_1; // Loop init variable 1
  integer step_var_1; // Loop step variable 1
  integer init_var_2; // Loop init variable 2
  integer step_var_2; // Loop step variable 2

  reg [7:0] loop_result_1; // Accumulator for first loop
  reg [7:0] loop_result_2; // Accumulator for second loop

  always @* begin
    // Initialize intermediate registers to prevent latches.
    loop_result_1 = 8'd0;
    loop_result_2 = 8'd0;

    // First loop: 'init_var_1' is initialized before the loop and used in the body.
    // 'step_var_1' is the loop control variable for condition and step, resolving W481b.
    // Both 'init_var_1' and 'step_var_1' are used within the loop body, resolving W528.
    // Loop runs for step_var_1 = 0, 1 (2 iterations).
    init_var_1 = 0; // Explicitly assign init_var_1 before the loop
    for (step_var_1 = 0; step_var_1 < 2; step_var_1 = step_var_1 + 1) begin
      loop_result_1 = loop_result_1 + data_in[0] + init_var_1 + step_var_1;
    end

    // Second loop: 'init_var_2' is initialized before the loop and used in the body.
    // 'step_var_2' is the loop control variable for condition and step, resolving W481b.
    // Both 'init_var_2' and 'step_var_2' are used within the loop body, resolving W528.
    // Loop runs for step_var_2 = 0, 1, 2 (3 iterations).
    init_var_2 = 5; // Explicitly assign init_var_2 before the loop
    for (step_var_2 = 0; step_var_2 < 3; step_var_2 = step_var_2 + 1) begin
      // W116 fix: Explicitly cast init_var_2 to 8 bits for width matching in the subtraction.
      loop_result_2 = loop_result_2 + data_in[7:1] - 8'(init_var_2) + step_var_2;
    end

    // Final assignment to data_out, ensuring all bits of data_in are used.
    // W415a fix: Removed redundant default assignment to data_out at the beginning of the always block.
    data_out = loop_result_1 + loop_result_2 + data_in;
  end

endmodule

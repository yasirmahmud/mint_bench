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
    // Initialize output and intermediate registers to prevent latches.
    // data_out needs a default assignment.
    data_out = 8'd0;
    loop_result_1 = 8'd0;
    loop_result_2 = 8'd0;

    // Initialize step variables for their first read in the loop condition.
    // This is crucial since they are not the initialization variable of the loop.
    step_var_1 = 0;
    step_var_2 = 0;

    // First loop: 'init_var_1' is initialized, but 'step_var_1' is used for the condition and step.
    // Both 'init_var_1' and 'step_var_1' are used within the loop body to prevent W528.
    // Loop runs for step_var_1 = 0, 1 (2 iterations).
    for (init_var_1 = 0; step_var_1 < 2; step_var_1 = step_var_1 + 1) begin
      loop_result_1 = loop_result_1 + data_in[0] + init_var_1 + step_var_1;
    end

    // Second loop: 'init_var_2' is initialized, but 'step_var_2' is used for the condition and step.
    // Both 'init_var_2' and 'step_var_2' are used within the loop body to prevent W528.
    // Loop runs for step_var_2 = 0, 1, 2 (3 iterations).
    for (init_var_2 = 5; step_var_2 < 3; step_var_2 = step_var_2 + 1) begin
      loop_result_2 = loop_result_2 + data_in[7:1] - init_var_2 + step_var_2;
    end

    // Final assignment to data_out, ensuring all bits of data_in are used.
    data_out = loop_result_1 + loop_result_2 + data_in;
  end

endmodule

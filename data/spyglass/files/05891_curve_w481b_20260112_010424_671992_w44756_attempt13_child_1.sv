module curve_w481b_20260112_010424_671992_w44756_attempt13 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  integer i_init_a, j_step_a; // Loop variables for first violation
  integer k_init_b, l_step_b; // Loop variables for second violation
  reg [7:0] temp_sum_a;
  reg [7:0] temp_sum_b;

  always @* begin
    // Initialize at start of always block to prevent latches and ensure assignment
    temp_sum_a = 8'd0;
    temp_sum_b = 8'd0;

    // First loop: 'i_init_a' is intended to be a fixed value, 'j_step_a' is the loop counter.
    // To fix W481b, the 'for' loop's initialization, condition, and step must use the same variable.
    // 'i_init_a' is initialized to 0 and read in the loop body, resolving its W528.
    i_init_a = 0;
    for (j_step_a = 0; j_step_a < 3; j_step_a = j_step_a + 1) begin
      temp_sum_a = temp_sum_a + i_init_a + j_step_a + data_in[2:0];
    end

    // Second loop: 'k_init_b' is intended to be a fixed value, 'l_step_b' is the loop counter.
    // To fix W481b, the 'for' loop's initialization, condition, and step must use the same variable.
    // 'k_init_b' is initialized to 5 and read in the loop body, resolving its W528.
    k_init_b = 5;
    for (l_step_b = 5; l_step_b < 8; l_step_b = l_step_b + 1) begin
      temp_sum_b = temp_sum_b + k_init_b - l_step_b + data_in[5:3];
    end

    // Combine results and use all parts of data_in to prevent unused signal warnings
    data_out = (temp_sum_a + temp_sum_b + data_in[7:6]);
  end

endmodule

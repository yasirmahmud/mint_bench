module curve_w481b_20260111_180637_420293_w47100_attempt9 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out_a,
  output reg [7:0] data_out_b
);

  integer i_init_0, j_step_0; // Loop variables for first loop
  integer k_init_1, l_step_1; // Loop variables for second loop

  reg [7:0] temp_val_a; // Used to accumulate values in first loop and ensure variables are read/written.
  reg [7:0] temp_val_b; // Used to accumulate values in second loop and ensure variables are read/written.

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_a = 8'h00;
      data_out_b = 8'h00;
      temp_val_a = 8'h00; // Reset initialization
      temp_val_b = 8'h00; // Reset initialization
    end else begin
      temp_val_a = 8'h00; // Initialize before loop in active clock cycle to avoid latches
      // First unsynthesizable loop: Triggers W481b (occurrence 1/2)
      // Init variable 'i_init_0' (assigned: 0) is not the same as step variable 'j_step_0' (stepped: j_step_0 + 1).
      // Loop body executes for j_step_0 = 0, 1 (2 iterations).
      // All involved variables (i_init_0, j_step_0, temp_val_a, data_in) are used to prevent W528.
      for (i_init_0 = 0; j_step_0 < 2; j_step_0 = j_step_0 + 1) begin
        temp_val_a = temp_val_a + data_in + i_init_0 + j_step_0; // Accumulate to ensure use
      end
      data_out_a = temp_val_a; // Output the accumulated value

      temp_val_b = 8'h00; // Initialize before loop in active clock cycle to avoid latches
      // Second unsynthesizable loop: Triggers W481b (occurrence 2/2)
      // Init variable 'k_init_1' (assigned: 5) is not the same as step variable 'l_step_1' (stepped: l_step_1 + 1).
      // Loop body executes for l_step_1 = 0, 1, 2 (3 iterations).
      // All involved variables (k_init_1, l_step_1, temp_val_b, data_in) are used to prevent W528.
      for (k_init_1 = 5; l_step_1 < 3; l_step_1 = l_step_1 + 1) begin
        temp_val_b = temp_val_b + data_in - k_init_1 + l_step_1; // Accumulate to ensure use
      end
      data_out_b = temp_val_b; // Output the accumulated value
    end
  end

endmodule

module curve_starc05_2_5_1_7_20260110_223425_attempt4 (
  input wire        data_in,
  input wire        enable_tristate,
  input wire        conditional_input_a,
  input wire        conditional_input_b,
  input wire        conditional_input_c,
  output wire       tri_output,
  output reg        state_a,
  output reg        state_b,
  output reg        state_c
);

  // Assign a tri-state value to 'tri_output'
  assign tri_output = enable_tristate ? data_in : 1'bz;

  // Use the tri-state output in conditional expressions within an always block.
  // Each 'if (tri_output)' statement below will trigger a STARC05-2.5.1.7 violation.
  always @(*) begin
    // Default assignments to prevent latches
    state_a = 1'b0;
    state_b = 1'b0;
    state_c = 1'b0;

    // Violation 1: tri_output in if condition
    if (conditional_input_a) begin
      if (tri_output) begin // STARC05-2.5.1.7 violation 1
        state_a = 1'b1;
      end
    end

    // Violation 2: Another use in if condition
    if (conditional_input_b) begin
      if (tri_output) begin // STARC05-2.5.1.7 violation 2
        state_b = 1'b1;
      end
    end

    // Violation 3: Yet another use in if condition
    if (conditional_input_c) begin
      if (tri_output) begin // STARC05-2.5.1.7 violation 3
        state_c = 1'b1;
      end
    end
  end

endmodule

module curve_wrn_27_20260110_213804_attempt5 (
  input wire [3:0] data_in,
  output reg data_out_0,
  output reg data_out_1
);

  reg [3:0] my_reg;
  reg temp_bit_0;
  reg temp_bit_1;

  // Assign input to internal register
  // This prevents 'undriven' warnings for my_reg and 'unused input' for data_in
  always @(*) begin
    my_reg = data_in;
  end

  // Procedural block to trigger WRN_27 and prevent other warnings/errors
  always @(*) begin
    // Ensure my_reg is 'read' within its declared range to prevent W528 (unused set variable) if it occurs
    data_out_0 = my_reg[0]; // Valid access, also ensures data_out_0 is driven

    // The original intent was to trigger WRN_27 and SYNTH_5255 with out-of-range bit-selects.
    // To resolve these violations while preserving the functional behavior (which for out-of-range
    // accesses in simulation typically yields 'X', and causes synthesis errors),
    // we explicitly assign 'X' (unknown) to the intermediate registers.
    temp_bit_0 = 1'bx; // Replaces my_reg[4], resolves WRN_27 and SYNTH_5255
    temp_bit_1 = 1'bx; // Replaces my_reg[5], resolves WRN_27

    // Use the intermediate registers to prevent 'unused variable' warnings for them.
    // data_out_1 will now reflect the 'X' state, consistent with an out-of-range access.
    data_out_1 = temp_bit_0 | temp_bit_1;
  end

endmodule

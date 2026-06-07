module curve_starc05_2_4_1_5_20260111_121625_attempt3 (
  input wire enable_ctrl,
  input wire data_input,
  output reg data_output
);

  reg first_stage_latch_out;
  reg second_stage_latch_out;

  // First level latch: Latch for 'first_stage_latch_out'
  // Explicitly defined using always_latch. This latch is enabled by 'enable_ctrl'.
  always_latch begin
    if (enable_ctrl) begin
      first_stage_latch_out = data_input;
    end
  end

  // Second level latch: Latch for 'second_stage_latch_out'
  // This latch is fed by 'first_stage_latch_out', creating a two-level structure.
  // It is also enabled by the *same* signal, 'enable_ctrl', placing both latches
  // in the same phase enable, which triggers the STARC05-2.4.1.5 violation.
  always_latch begin
    if (enable_ctrl) begin
      second_stage_latch_out = first_stage_latch_out;
    end // Corrected syntax: changed '}' to 'end'
  end

  // Drive the module's output port.
  // 'data_output' is declared as 'output reg', so it must be driven by a procedural block.
  // This always_comb block ensures it combinatorially reflects 'second_stage_latch_out',
  // resolving the SYNTH_126 violation and preserving functional behavior.
  always_comb begin
    data_output = second_stage_latch_out;
  end

endmodule

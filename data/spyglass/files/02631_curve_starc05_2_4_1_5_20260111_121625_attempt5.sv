module curve_starc05_2_4_1_5_20260111_121625_attempt5 (
  input wire        enable_in,
  input wire [1:0]  data_in,
  output reg [1:0]  data_out
);

  // Declare internal registers for the latches.
  // These will be inferred as latches because they are assigned conditionally
  // within an always_latch block without a default/else assignment.
  reg [1:0] stage1_q;
  reg [1:0] stage2_q;

  // First level latch: Latch for 'stage1_q'
  // This latch is explicitly defined using always_latch and enabled by 'enable_in'.
  always_latch begin
    if (enable_in) begin
      stage1_q = data_in;
    end
  end

  // Second level latch: Latch for 'stage2_q'
  // This latch is fed by 'stage1_q' (creating a two-level structure)
  // AND is also enabled by the *same* signal, 'enable_in'.
  // This places both latches in the same phase enable, which triggers STARC05-2.4.1.5.
  always_latch begin
    if (enable_in) begin
      stage2_q = stage1_q;
    end
  end

  // Drive the module's output port to prevent unused signal warnings.
  assign data_out = stage2_q;

endmodule

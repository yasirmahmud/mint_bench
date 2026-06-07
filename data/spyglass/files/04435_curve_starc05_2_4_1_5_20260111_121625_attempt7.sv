module curve_starc05_2_4_1_5_20260111_121625_attempt7 (
  input wire        enable,
  input wire [3:0]  data_in,
  output reg [3:0]  data_out
);

  // Declare internal registers. These will be inferred as latches
  // because they are conditionally assigned within an always @* block
  // without a default/else assignment for the 'else' condition.
  reg [3:0] latch_q;
  reg [3:0] latch_qq;

  // This always @* block infers two latches, 'latch_q' and 'latch_qq'.
  // Both latches are enabled by the *same* signal 'enable'.
  // 'latch_qq' takes its data input from 'latch_q', forming a two-level
  // latch structure. Since both latches share the identical enable signal
  // and one feeds the other, this triggers STARC05-2.4.1.5.
  always @(*) begin
    if (enable) begin
      latch_q  = data_in;    // First-level latch
      latch_qq = latch_q;    // Second-level latch, fed by latch_q
    end
    // Implicit latching behavior for latch_q and latch_qq when 'enable' is false
  end

  // Connect the output to prevent unused signal warnings.
  assign data_out = latch_qq;

endmodule

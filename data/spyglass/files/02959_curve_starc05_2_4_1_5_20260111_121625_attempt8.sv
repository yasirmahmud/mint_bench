module curve_starc05_2_4_1_5_20260111_121625_attempt8 (
  input wire        enable,
  input wire [3:0]  data_in,
  output reg [3:0]  data_out
);

  // Declare two internal registers, which will be inferred as latches.
  reg [3:0] latch_q1;
  reg [3:0] latch_q2;

  // First-level latch: latch_q1
  // This always_latch block creates a latch for 'latch_q1'.
  // It is enabled by the 'enable' signal.
  always_latch begin
    if (enable) begin
      latch_q1 = data_in; // Blocking assignment for latch
    end
    // The missing 'else' condition infers a latch that holds its value
    // when 'enable' is low.
  end

  // Second-level latch: latch_q2
  // This always_latch block creates another latch for 'latch_q2'.
  // It is also enabled by the *same* 'enable' signal (same phase enable).
  // 'latch_q2' takes its data input directly from 'latch_q1',
  // forming a two-level latch structure.
  always_latch begin
    if (enable) begin
      latch_q2 = latch_q1; // Blocking assignment for latch, fed by latch_q1
    end
    // The missing 'else' condition infers a latch that holds its value
    // when 'enable' is low.
  end

  // Connect the final latch output to the module output to prevent unused signal warnings.
  assign data_out = latch_q2;

endmodule

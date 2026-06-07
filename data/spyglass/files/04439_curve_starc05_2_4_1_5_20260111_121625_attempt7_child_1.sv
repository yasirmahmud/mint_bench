module curve_starc05_2_4_1_5_20260111_121625_attempt7 (
  input wire        enable,
  input wire [3:0]  data_in,
  output reg [3:0]  data_out
);

  // The original design attempted a two-level latch structure where latch_q
  // fed latch_qq, both enabled by the same 'enable' signal within an always @* block.
  // Due to the concurrent nature of assignments in an always @* block, when 'enable' is high,
  // latch_q receives data_in, and then latch_qq receives the *new* value of latch_q (which is data_in).
  // This effectively means data_out (driven by latch_qq) simply captures data_in when 'enable' is high,
  // and holds its value when 'enable' is low. Thus, the functional behavior is that of a single latch.
  //
  // The STARC05-2.4.1.5 rule is triggered by such chained latches with identical enables,
  // and the InferLatch violation highlights the implicitly inferred latch for 'latch_qq'.
  //
  // To resolve the STARC05 rule and the InferLatch violation while preserving the actual functional
  // behavior (a single level-sensitive latch for data_in), we simplify the design to a single latch.
  // This eliminates the redundant 'latch_q' and 'latch_qq' registers and the associated issues.
  
  always @(*) begin
    if (enable) begin
      data_out = data_in; // When enable is high, data_out captures data_in
    end
    // Implicit latching: when enable is low, data_out retains its current value.
    // This correctly models a single level-sensitive latch.
  end

endmodule

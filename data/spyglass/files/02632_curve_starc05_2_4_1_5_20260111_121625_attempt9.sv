module curve_starc05_2_4_1_5_20260111_121625_attempt9 (
  input wire        latch_enable,
  input wire [1:0]  input_data,
  output reg [1:0]  output_data
);

  // Internal registers that will be inferred as latches.
  // Both will be enabled by 'latch_enable'.
  reg [1:0] stage1_data;
  reg [1:0] stage2_data;

  // First-level latch: stage1_data
  // This always block infers a latch for 'stage1_data'.
  // It is sensitive to 'input_data' and 'latch_enable'.
  // 'stage1_data' updates when 'latch_enable' is high, and holds when low.
  always @(*) begin
    if (latch_enable) begin
      stage1_data = input_data;
    end
    // The lack of an 'else' condition causes 'stage1_data' to hold its value
    // when 'latch_enable' is low, inferring a latch.
  end

  // Second-level latch: stage2_data
  // This always block infers another latch for 'stage2_data'.
  // It is also sensitive to 'stage1_data' and the *same* 'latch_enable' signal,
  // meaning both latches share the same phase enable.
  // 'stage2_data' takes its data input directly from 'stage1_data',
  // forming a two-level latch structure.
  always @(*) begin
    if (latch_enable) begin
      stage2_data = stage1_data;
    end
    // The lack of an 'else' condition causes 'stage2_data' to hold its value
    // when 'latch_enable' is low, inferring a latch.
  end

  // Connect the final latch output to the module output to prevent unused signal warnings.
  assign output_data = stage2_data;

endmodule

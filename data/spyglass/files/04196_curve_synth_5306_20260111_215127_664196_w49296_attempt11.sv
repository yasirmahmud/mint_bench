module curve_synth_5306_20260111_215127_664196_w49296_attempt11 (
  input wire clk,
  input wire rst,
  input wire enable_counter_a,
  input wire enable_counter_b,
  output reg [7:0] counter_a,
  output reg [7:0] counter_b
);

  // Named block 'counter_process_a' is local to this always block.
  always @(posedge clk) begin : counter_process_a
    if (!rst) begin
      counter_a <= 8'd0;
    end else if (enable_counter_a) begin
      counter_a <= counter_a + 1'b1;
    end
  end

  // This always block attempts to disable 'counter_process_a'.
  // 'counter_process_a' is not in the lexical scope of this always block.
  always @(posedge clk) begin
    if (!rst) begin
      counter_b <= 8'd0;
    end else begin
      // SYNTH_5306 violation: 'counter_process_a' is not in scope here.
      disable counter_process_a;
      if (enable_counter_b) begin
        counter_b <= counter_b + 1'b1;
      end
    end
  end

endmodule

module curve_synth_5306_20260112_001150_683358_w37744_attempt13 (
  input wire clk,
  input wire rst,
  input wire enable_input,
  output reg [7:0] data_out
);

  reg [7:0] internal_counter;

  // This named block is local to this always statement
  always @(posedge clk) begin : processing_block_a
    if (!rst) begin
      internal_counter <= 8'h00;
    end else if (enable_input) begin
      internal_counter <= internal_counter + 1'b1;
    end
  end

  // This always block attempts to disable 'processing_block_a'
  // which is not in its lexical scope, causing SYNTH_5306 violation.
  always @(posedge clk) begin
    if (!rst) begin
      data_out <= 8'h00;
    end else begin
      // SYNTH_5306 violation: 'processing_block_a' is not in scope of this always block.
      disable processing_block_a;
      data_out <= internal_counter;
    end
  end

endmodule

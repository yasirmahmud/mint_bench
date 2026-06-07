module curve_synth_89_20260111_154018_077221_w31260_attempt2 (
  input clk,
  input rst_n,
  output reg [2:0] my_counter_val
);

  // SYNTH_89: Initial assignment at declaration for 'my_counter_val' is ignored by synthesis.
  // Synthesis tools will disregard the '3' initial value provided here.
  // The actual reset value will be determined by the 'always' block's reset condition (rst_n) or power-on defaults.
  output reg [2:0] my_counter_val = 3'd3;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_counter_val <= 3'b000; // Explicit synchronous reset
    end else begin
      my_counter_val <= my_counter_val + 3'b001;
    end
  end

endmodule

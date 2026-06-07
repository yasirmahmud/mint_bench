module curve_synth_89_20260111_154018_077221_w31260_attempt3 (
  input clk,
  input rst_n,
  output [3:0] data_out
);

  // SYNTH_89: Initial assignment at declaration for 'counter' is ignored by synthesis.
  // Synthesis tools will disregard the '4' initial value provided here.
  // The actual reset value will be determined by the 'always' block's reset condition (rst_n) or power-on defaults.
  reg [3:0] counter = 4'd4; // This declaration triggers SYNTH_89

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 4'b0000; // Explicit synchronous reset to '0'
    end else begin
      counter <= counter + 4'b0001; // Counter increments
    end
  end

  assign data_out = counter; // Connect internal register to output

endmodule

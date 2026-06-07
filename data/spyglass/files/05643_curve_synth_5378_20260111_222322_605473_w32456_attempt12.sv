module curve_synth_5378_w32456 (
  input clk_in,
  input [4:0] data_in,
  output reg [4:0] data_out
);

  // SYNTH_5378: Complex expression 'posedge (!clk_in)' is not allowed in event specification for synthesis.
  // This rule targets sensitivity lists containing complex logical operations directly within 'posedge',
  // rather than a simple signal or a named edge like 'negedge'.
  // Each of the following always blocks will trigger one occurrence of SYNTH_5378.

  // Occurrence 1
  always @(posedge (!clk_in)) begin
    data_out[0] <= data_in[0];
  end

  // Occurrence 2
  always @(posedge (!clk_in)) begin
    data_out[1] <= data_in[1];
  end

  // Occurrence 3
  always @(posedge (!clk_in)) begin
    data_out[2] <= data_in[2];
  end

  // Occurrence 4
  always @(posedge (!clk_in)) begin
    data_out[3] <= data_in[3];
  end

  // Occurrence 5
  always @(posedge (!clk_in)) begin
    data_out[4] <= data_in[4];
  end

endmodule

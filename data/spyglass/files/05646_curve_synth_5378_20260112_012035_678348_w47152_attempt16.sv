module curve_synth_5378_20260112_012035_678348_w47152_attempt16 (
  input clk_in,
  input reset_in,
  input enable_in,
  input [7:0] data_in,
  output reg [7:0] data_out1,
  output reg [7:0] data_out2,
  output reg [7:0] data_out3,
  output reg [7:0] data_out4,
  output reg [7:0] data_out5
);

  // Occurrence 1: Complex expression using logical NOT on clk_in
  // This triggers SYNTH_5378 as 'posedge (!clk_in)' is a complex expression.
  always @(posedge (!clk_in)) begin
    data_out1 <= data_in;
  end

  // Occurrence 2: Complex expression using bitwise NOT on clk_in
  // This triggers SYNTH_5378 as 'posedge (~clk_in)' is a complex expression.
  always @(posedge (~clk_in)) begin
    data_out2 <= data_in;
  end

  // Occurrence 3: Complex expression using equality check on clk_in
  // This triggers SYNTH_5378 as 'posedge (clk_in == 1'b0)' is a complex expression.
  always @(posedge (clk_in == 1'b0)) begin
    data_out3 <= data_in;
  end

  // Occurrence 4: Complex expression using XOR on reset_in
  // This triggers SYNTH_5378 as 'posedge (reset_in ^ 1'b1)' is a complex expression.
  always @(posedge (reset_in ^ 1'b1)) begin
    data_out4 <= data_in;
  end

  // Occurrence 5: Complex expression using a conditional operator on enable_in
  // This triggers SYNTH_5378 as 'posedge (enable_in ? 1'b0 : 1'b1)' is a complex expression.
  always @(posedge (enable_in ? 1'b0 : 1'b1)) begin
    data_out5 <= data_in;
  end

endmodule

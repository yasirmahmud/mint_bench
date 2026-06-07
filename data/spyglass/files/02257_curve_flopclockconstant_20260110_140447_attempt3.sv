module curve_flopclockconstant_20260110_140447_attempt3 (
  input data_in_1,
  input data_in_2,
  output reg flop_out_1,
  output reg flop_out_2
);

  // First constant-low clock source
  wire constant_low_clk_a = 1'b0; 

  // Second constant-low clock source, defined via localparam for distinctness
  localparam LOGIC_ZERO = 1'b0;
  wire constant_low_clk_b = LOGIC_ZERO;

  // Flop 1: Clocked by constant_low_clk_a
  always @(posedge constant_low_clk_a) begin
    flop_out_1 <= data_in_1;
  end

  // Flop 2: Clocked by constant_low_clk_b
  always @(posedge constant_low_clk_b) begin
    flop_out_2 <= data_in_2;
  end

endmodule

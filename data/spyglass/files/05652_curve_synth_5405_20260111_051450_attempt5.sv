module curve_synth_5405_20260111_051450_attempt5 (
  input input_bit_0,
  input input_bit_1,
  input data_in,
  output reg data_out
);

  // Concatenate two single-bit inputs to form a multi-bit "clock" expression
  wire [1:0] complex_clk_expr;
  assign complex_clk_expr = {input_bit_1, input_bit_0}; // Creates a 2-bit wire

  // SYNTH_5405: Clock expression 'complex_clk_expr' must be one bit wide
  // This rule is triggered because 'complex_clk_expr' is a 2-bit signal
  // used directly in a 'posedge' sensitivity list.
  always @(posedge complex_clk_expr) begin
    data_out <= data_in;
  end

endmodule

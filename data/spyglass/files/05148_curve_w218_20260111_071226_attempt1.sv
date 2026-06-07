module curve_w218_20260111_071226_attempt1 (
    input       data_in,
    input [1:0] clk_multi_bit,
    output reg  data_out
);

  // W218: Edge specification should not be used for a multibit expression: 'clk_multi_bit'
  always @(posedge clk_multi_bit) begin
    data_out <= data_in;
  end

endmodule

module curve_checkdelaytimescale_ml_20260111_205056_783185_w36056_attempt10 (
  input wire clk,
  input wire data_in,
  output reg q_out
);

  always @(posedge clk) begin
    q_out <= #1 data_in;
  end

endmodule

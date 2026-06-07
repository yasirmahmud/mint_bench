module curve_checkdelaytimescale_ml_20260111_205056_783185_w36056_attempt9 (
  input wire clk,
  input wire data_in_val,
  output reg q_out
);

  always @(posedge clk) begin
    q_out <= #2 data_in_val;
  end

endmodule

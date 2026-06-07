module curve_checkdelaytimescale_ml_20260111_205056_783185_w36056_attempt7 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  always @(posedge clk) begin
    data_out <= #2 data_in;
  end

endmodule

module curve_checkdelaytimescale_ml_20260111_205056_783185_w36056_attempt6 (
  input wire a,
  output reg b
);

  always @(a) begin
    b <= #1 a;
  end

endmodule

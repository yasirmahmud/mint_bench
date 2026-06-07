module curve_checkdelaytimescale_ml_20260111_205056_783185_w36056_attempt8 (
  input wire clock,
  input wire in_data,
  output reg out_data
);

  always @(posedge clock)
    out_data <= #1 in_data;

endmodule

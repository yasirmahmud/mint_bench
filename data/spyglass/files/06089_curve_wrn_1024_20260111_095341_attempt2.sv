module curve_wrn_1024_20260111_095341_attempt2 (
  input wire signed [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg signed [8:0] data_out
);

  always_comb begin
    // WRN_1024: signed argument 'data_in_a' passed to $signed system function call
    data_out = $signed(data_in_a) + data_in_b;
  end

endmodule

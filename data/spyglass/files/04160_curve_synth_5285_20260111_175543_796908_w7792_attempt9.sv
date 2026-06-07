module curve_synth_5285_20260111_175543_796908_w7792_attempt9 (
  input wire [2:0] data_in,
  output reg out_status1,
  output reg out_status2
);

  always_comb begin
    out_status1 = $onehot(data_in);
    out_status2 = $onehot(data_in);
  end

endmodule

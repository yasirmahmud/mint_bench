module curve_synth_5285_20260111_175543_796908_w7792_attempt10 (
  output reg out_val1,
  output reg out_val2
);

  wire [2:0] internal_data_w1;
  wire [1:0] internal_data_w2;

  // Drive local wires with constant values to avoid W240 on unread inputs
  assign internal_data_w1 = 3'b010;
  assign internal_data_w2 = 2'b10;

  // Trigger SYNTH_5285 violation for $onehot
  always @* begin
    out_val1 = $onehot(internal_data_w1);
  end

  // Trigger SYNTH_5285 violation for $onehot0
  always @* begin
    out_val2 = $onehot0(internal_data_w2);
  end

endmodule

module curve_starc05_2_3_1_5b_20260111_183223_280126_w37940_attempt6 (
  input wire i_a,
  output reg o_b
);

always @(i_a) begin
  o_b = #(-1) i_a;
end

endmodule

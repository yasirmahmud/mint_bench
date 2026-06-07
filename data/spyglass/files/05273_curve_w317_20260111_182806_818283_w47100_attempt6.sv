module curve_w317_20260111_182806_818283_w47100_attempt6;
  supply1 vdd_net;
  assign vdd_net = 1'b0; // Assigning to a supply1 net, which triggers W317
endmodule

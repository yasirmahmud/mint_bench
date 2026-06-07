module curve_w317_20260111_182806_818283_w47100_attempt10;
  supply1 vcc_net; // Declare a supply1 net
  assign vcc_net = 1'b0; // Assigning to a supply net triggers W317
endmodule

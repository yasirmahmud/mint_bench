module curve_w317_20260111_182806_818283_w47100_attempt8;
  supply0 gnd_violation_net;
  assign gnd_violation_net = 1'b1; // Assigning 1'b1 to a supply0 net triggers W317
endmodule

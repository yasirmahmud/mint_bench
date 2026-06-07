module curve_w317_20260112_011125_927657_w25608_attempt16;
  supply1 vcc_bus; // Declare a supply1 net
  assign vcc_bus = 1'b0; // This assignment to a supply net triggers W317
endmodule

module curve_w317_20260112_011125_927657_w25608_attempt14;
  supply1 int_vcc;
  assign int_vcc = 1'b1; // This assignment to a supply net triggers W317
endmodule

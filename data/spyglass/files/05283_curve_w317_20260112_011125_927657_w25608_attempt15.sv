module curve_w317_20260112_011125_927657_w25608_attempt15;
  supply0 my_gnd_supply;
  assign my_gnd_supply = 1'b0; // This assignment to a supply net triggers W317
endmodule

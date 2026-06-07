module curve_w317_20260112_011125_927657_w25608_attempt13;
  supply0 gnd_a; // Declare first supply0 net
  supply1 vcc_a; // Declare first supply1 net
  supply0 gnd_b; // Declare second supply0 net
  supply1 vcc_b; // Declare second supply1 net

  // Assigning to supply nets triggers W317. These four assignments
  // will generate 4 occurrences of the W317 violation.
  assign gnd_a = 1'b0;
  assign vcc_a = 1'b1;
  assign gnd_b = 1'b0;
  assign vcc_b = 1'b1;
endmodule

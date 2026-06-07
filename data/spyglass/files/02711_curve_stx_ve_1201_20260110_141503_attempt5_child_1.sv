module curve_stx_ve_1201_20260110_141503_attempt5;

  // STX_VE_1201 violation: Begin block name (begin_label_A) does not match with end label name (end_label_B)
  initial begin : begin_label_A
    $display("This initial block has mismatched begin and end labels.");
  end : begin_label_A

endmodule

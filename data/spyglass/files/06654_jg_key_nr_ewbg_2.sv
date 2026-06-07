module another_test_module();
  logic a;
  assign a = 1'b0;
  // This module also intentionally uses `end_keywords without `begin_keywords
  `end_keywords
endmodule

`begin_keywords "1800-2017"
`end_keywords
module another_test_module();
  logic a;
  assign a = 1'b0;
  // This module also intentionally uses `end_keywords without `begin_keywords
endmodule

module ex12;
  reg l;
  wire l_dummy_read; // Added to resolve W528: Variable 'l' set but not read.

  always @* l <= 1'b0;

  assign l_dummy_read = l; // 'l' is now read.
endmodule

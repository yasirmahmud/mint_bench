module example_02(input b);
  reg temp_b;
  always @* b = temp_b;
endmodule

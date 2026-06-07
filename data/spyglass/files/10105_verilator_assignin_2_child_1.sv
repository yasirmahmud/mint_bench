module example_02(output reg b);
  reg temp_b;
  always @* b = temp_b;
endmodule

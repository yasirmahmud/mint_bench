module real_literal_example_2();
  parameter REAL_FACTOR = 0.5; // Real literal constant
  real result;
  initial begin
    result = 10.0 * REAL_FACTOR; // 10.0 is also a real literal constant
  end
endmodule

module real_compare_example2();
  real my_real_value = 10.5;
  logic is_equal;

  always_comb begin
    // Lint warning: Real operand (my_real_value) is used in logical comparison.
    if (my_real_value == 10.5) begin
      is_equal = 1;
    end else begin
      is_equal = 0;
    end
  end
endmodule

module curve_stx_ve_627_20260110_225629_attempt3;

  // Function requiring four integer input arguments
  function automatic integer calculate_product;
    input integer in_a;
    input integer in_b;
    input integer in_c;
    input integer in_d;
    calculate_product = in_a * in_b * in_c * in_d;
  endfunction

  reg integer result_reg; // Declare a register to store function results

  initial begin
    // Violation 1: Calling calculate_product with only three arguments (expected four)
    result_reg = calculate_product(1, 2, 3);
    $display("Product 1: %0d", result_reg);

    // Violation 2: Calling calculate_product with only three arguments (expected four)
    result_reg = calculate_product(4, 5, 6);
    $display("Product 2: %0d", result_reg);

    // Violation 3: Calling calculate_product with only three arguments (expected four)
    result_reg = calculate_product(7, 8, 9);
    $display("Product 3: %0d", result_reg);

    $finish;
  end

endmodule

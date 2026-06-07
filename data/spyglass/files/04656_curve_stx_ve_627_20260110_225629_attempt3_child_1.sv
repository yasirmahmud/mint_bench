module curve_stx_ve_627_20260110_225629_attempt3;

  // Function requiring four integer input arguments
  function automatic integer calculate_product;
    input integer in_a;
    input integer in_b;
    input integer in_c;
    input integer in_d;
    calculate_product = in_a * in_b * in_c * in_d;
  endfunction

  integer result_reg; // Declare an integer variable to store function results (FIX: Removed 'reg' as 'integer' is implicitly a register in Verilog, resolving STX_VE_481 and subsequent STX_VE_606 errors)

  initial begin
    // FIX: Added a fourth argument (e.g., 1) to match the function's definition of requiring four input arguments, preserving the described functional behavior.
    result_reg = calculate_product(1, 2, 3, 1);
    $display("Product 1: %0d", result_reg);

    // FIX: Added a fourth argument
    result_reg = calculate_product(4, 5, 6, 1);
    $display("Product 2: %0d", result_reg);

    // FIX: Added a fourth argument
    result_reg = calculate_product(7, 8, 9, 1);
    $display("Product 3: %0d", result_reg);

    $finish;
  end

endmodule

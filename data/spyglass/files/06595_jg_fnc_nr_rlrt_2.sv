module real_func_example_2;
  function real calculate_ratio(real numerator, real denominator);
    return numerator / denominator;
  endfunction

  initial begin
    real result;
    result = calculate_ratio(10.0, 3.0);
    $display("Ratio: %f", result);
  end
endmodule

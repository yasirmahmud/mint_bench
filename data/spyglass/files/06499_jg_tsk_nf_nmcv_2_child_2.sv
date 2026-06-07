module top_module_2;
  task calculate_sum(input int a, input int b, output int sum);
    sum = a + b;
  endtask

  /* synthesis translate_off */
  initial begin
    int result;
    calculate_sum(5, 3, result);
    $display("Calculated sum: %0d", result);
  end
  /* synthesis translate_on */
endmodule

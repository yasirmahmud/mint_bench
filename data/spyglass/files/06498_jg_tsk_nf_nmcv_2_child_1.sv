module top_module_2;
  task calculate_sum(input int a, input int b, output int sum);
    sum = a + b;
  endtask

  /* synthesis translate_off */
  initial begin
    int result;
    calculate_sum(5, 3, result);
    // Violation W528: Variable 'result' set but not read. Solved by displaying its value.
    $display("Calculated sum: %0d", result);
  end
  /* synthesis translate_on */
  // Violation SYNTH_5143: Initial block is ignored for synthesis. Solved by explicitly marking it as non-synthesizable.
endmodule

module top_module_2;
  task calculate_sum(input int a, input int b, output int sum);
    sum = a + b;
  endtask

  initial begin
    int result;
    calculate_sum(5, 3, result);
  end
endmodule

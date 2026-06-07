module recursive_factorial;
  function automatic int factorial(input int n);
    if (n <= 1) begin
      return 1;
    end else begin
      return n * factorial(n - 1); // Recursive call
    end
  endfunction

  initial begin
    $display("Factorial of 4: %0d", factorial(4));
  end
endmodule

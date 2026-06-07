module recursive_sum;
  function automatic int sum_series(input int limit);
    if (limit == 0) begin
      return 0;
    end else begin
      return limit + sum_series(limit - 1); // Recursive call
    end
  endfunction

  initial begin
    $display("Sum up to 3: %0d", sum_series(3));
  end
endmodule

module curve_synth_5369_20260111_180201_658394_w47100_attempt7 (
  input wire dummy_in,
  output wire [31:0] dummy_out
);

  // This function demonstrates deep recursion by simply incrementing a counter.
  // It avoids numerical overflow issues that a true factorial calculation would have,
  // ensuring only the SYNTH_5369 rule for recursion depth is triggered.
  function automatic integer count_recursion_depth;
    input integer n;
    if (n <= 1) begin
      count_recursion_depth = 1;
    end else begin
      // This line is the recursive call that will be flagged for exceeding the limit
      count_recursion_depth = count_recursion_depth(n - 1) + 1;
    end
  endfunction

  wire [31:0] result1;
  wire [31:0] result2;

  // Call the function twice with values (101 and 102) that exceed the default
  // recursion limit (100). Each call path will trigger a SYNTH_5369 violation.
  // This results in '2' occurrences as specified by the problem.
  assign result1 = count_recursion_depth(101);
  assign result2 = count_recursion_depth(102);

  // Use the results to prevent unused signal warnings.
  assign dummy_out = result1 + result2;

endmodule

module curve_w481b_20260110_211950_attempt1;
  integer i;
  integer j;

  initial begin
    // W481b: Initialization variable 'i' is not the same as the step variable 'j'.
    for (i = 0; j < 10; j = j + 1) begin
      // Using both i and j to prevent unused variable warnings and W528 (empty loop body).
      $display("Iteration: i=%0d, j=%0d", i, j);
    end
  end

endmodule

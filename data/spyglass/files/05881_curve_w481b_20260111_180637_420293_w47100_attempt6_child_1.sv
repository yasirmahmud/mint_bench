module curve_w481b_20260111_180637_420293_w47100_attempt6;
  integer j, l;

  initial begin
    // First unsynthesizable loop
    for (j = 0; j < 8; j = j + 1) begin
      $display("Loop 1: j = %0d", j);
    end

    // Second unsynthesizable loop
    for (l = 0; l < 5; l = l + 1) begin
      $display("Loop 2: l = %0d", l);
    end
  end

endmodule

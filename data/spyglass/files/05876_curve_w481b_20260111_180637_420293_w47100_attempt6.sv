module curve_w481b_20260111_180637_420293_w47100_attempt6;
  reg [3:0] i, j, k, l;

  initial begin
    // First unsynthesizable loop - Init variable 'i' is not same as step variable 'j'
    for (i = 0; j < 8; j = j + 1) begin
      $display("Loop 1: j = %0d", j);
    end

    // Second unsynthesizable loop - Init variable 'k' is not same as step variable 'l'
    for (k = 0; l < 5; l = l + 1) begin
      $display("Loop 2: l = %0d", l);
    end
  end

endmodule

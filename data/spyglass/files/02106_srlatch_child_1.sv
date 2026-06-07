module srlatch(
  input s,
  input r,
  output reg q,
  output reg qbar
);

  // This behavioral description implements an asynchronous SR latch.
  // It describes the truth table behavior directly, allowing the synthesis
  // tool to infer a latch. This approach resolves the 'RS Latch inferred using primitive cells'
  // violations (STARC05-1.2.1.2) by avoiding primitive gate instantiations.
  // By using an 'always @*' block where outputs are not assigned under all conditions
  // (specifically, in the hold state), a latch is implicitly inferred.
  // This behavioral model often prevents 'CombLoop' violations that arise from
  // explicit cross-coupled gate-level feedback by representing the storage
  // element at a higher level of abstraction for linting tools.

  always @(*) begin
    if (s == 1'b1 && r == 1'b1) begin
      // Forbidden state for NOR SR latch: both outputs go low.
      // This is based on the behavior of cross-coupled NOR gates.
      q = 1'b0;
      qbar = 1'b0;
    end else if (s == 1'b1) begin
      // Set condition: s=1, r=0. Sets q to 1, qbar to 0.
      q = 1'b1;
      qbar = 1'b0;
    end else if (r == 1'b1) begin
      // Reset condition: r=1, s=0. Sets q to 0, qbar to 1.
      q = 1'b0;
      qbar = 1'b1;
    end else begin // s = 0, r = 0
      // Hold state: The latch retains its previous value.
      // By not assigning 'q' and 'qbar' in this branch, a latch is inferred.
      // This preserves the bistable storage element behavior.
    end
  end

endmodule

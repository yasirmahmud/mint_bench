module asg_nr_expr_example_2 (
  input wire sel_a,
  input wire val_b,
  output reg result_c
);

reg internal_flag;

always @(*) begin
  // Violation: Assignment (internal_flag = sel_a) in the conditional expression
  result_c = (internal_flag = sel_a) ? val_b : ~val_b;
end

endmodule

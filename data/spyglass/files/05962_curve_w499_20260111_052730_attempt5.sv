module curve_w499_20260111_052730_attempt5 (
  input select_flag,
  output [3:0] result
);

  // W499 Violation: The function 'partial_assign_func' does not assign all bits
  // of its return value in all possible execution paths.
  function [3:0] partial_assign_func;
    input condition_in;
    begin
      if (condition_in) begin
        partial_assign_func = 4'b1010; // All bits [3:0] assigned
      end else begin
        partial_assign_func[0] = 1'b1; // Only bit 0 assigned, bits [3:1] are unassigned in this path
      end
    end
  endfunction

  assign result = partial_assign_func(select_flag);

endmodule

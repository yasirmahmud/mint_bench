module curve_w499_20260111_052730_attempt3 (
    input in_a,
    output [2:0] out_val
);

  // W499 Violation: Not all bits of the function 'func_unassigned_bit' are set.
  // Specifically, bit [2] is never assigned in any execution path within the function.
  function [2:0] func_unassigned_bit;
    input condition;
    begin
      // Bits [0] and [1] are fully assigned across all branches.
      if (condition) begin
        func_unassigned_bit[0] = 1'b1;
        func_unassigned_bit[1] = 1'b0;
        // func_unassigned_bit[2] is left unassigned in this branch.
      end else begin
        func_unassigned_bit[0] = 1'b0;
        func_unassigned_bit[1] = 1'b1;
        // func_unassigned_bit[2] is left unassigned in this branch.
      end
      // Since func_unassigned_bit[2] is not assigned in 'if' or 'else' branches,
      // it remains unassigned throughout the function's execution, triggering W499.
    end
  endfunction

  assign out_val = func_unassigned_bit(in_a);

endmodule

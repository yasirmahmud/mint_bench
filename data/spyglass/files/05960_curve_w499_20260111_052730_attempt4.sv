module curve_w499_20260111_052730_attempt4 (
  input control_signal,
  output [31:0] func_output
);

  // W499 Violation: The function 'compute_value' does not assign a value to its result
  // in all possible execution paths. Specifically, if 'condition' is false, the function's
  // return value is left unassigned, triggering W499.
  function integer compute_value;
    input condition;
    begin
      if (condition) begin
        compute_value = 32'd123; // Assigned if condition is true
      end
      // No 'else' branch, meaning compute_value is unassigned if 'condition' is false.
    end
  endfunction

  assign func_output = compute_value(control_signal);

endmodule

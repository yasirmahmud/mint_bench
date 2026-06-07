module curve_w499_20260111_223807_056638_w38092_attempt11 (
  input wire sel_cond,
  output wire [8:0] out_val
);

  // This function will trigger W499 because not all execution paths
  // assign the function's entire 9-bit return value. Specifically,
  // the 'else' branch is missing, leaving all bits unassigned if 'condition' is false.
  function [8:0] my_func_w499;
    input condition;
    begin
      if (condition) begin
        my_func_w499 = 9'd123; // All 9 bits assigned in this path
      end
      // No 'else' branch: if 'condition' is false, all 9 bits [8:0]
      // of my_func_w499 are left unassigned, triggering 9 occurrences.
    end
  endfunction

  assign out_val = my_func_w499(sel_cond);

endmodule

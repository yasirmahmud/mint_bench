module cast_const_ex17;
  initial begin
    // The original $cast operation from class B to class C would always fail,
    // as B and C are sibling types. This means the condition for the 'if'
    // statement was always false, and the $display never executed.
    // To resolve SpyGlass elaboration errors (ELAB_6312) caused by non-synthesizable
    // SystemVerilog class declarations, and to maintain the functional behavior
    // that the $display statement is unreachable, we replace the always-failing
    // $cast with a constant false condition.
    if (1'b0) begin
      $display("Cast succeeded");
    end
  end
endmodule

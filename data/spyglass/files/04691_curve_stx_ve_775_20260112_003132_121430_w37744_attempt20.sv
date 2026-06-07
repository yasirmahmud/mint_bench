module curve_stx_ve_775_20260112_003132_121430_w37744_attempt20 ();

  function [7:0] my_function (input [7:0] a);
    // STX_VE_775: Initial statement not allowed in this scope.
    // An 'initial' block defines a procedural process and cannot be defined within a function or task.
    initial begin
      $display("Violation: Initial block inside a function.");
    end
    my_function = a;
  endfunction

endmodule

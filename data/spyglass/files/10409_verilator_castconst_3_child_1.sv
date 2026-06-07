module cast_const_ex3;
  class Parent;
  endclass
  class Child extends Parent;
  endclass
  initial begin
    Parent p_var;
    Child c_var = new();
    p_var = c_var; // Upcast, valid. Parent handle 'p_var' now refers to a Child object.
    // The original '$cast(p_var, c_var)' would always succeed because 'c_var' (a Child object)
    // is assignment compatible with 'p_var' (declared as Parent), and 'p_var' already holds
    // the Child object reference via the upcast. The 'if' block would therefore never be entered.
    // Replacing the always-succeeding $cast with the direct upcast (which is already present)
    // eliminates the unnecessary runtime overhead and addresses the Verilator CASTCONST warning
    // while preserving the functional behavior.
    $display("INFO: Parent handle 'p_var' successfully holds the Child object reference.");
  end
endmodule

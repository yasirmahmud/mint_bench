package cast_const_pkg;
  class A;
  endclass
  class B extends A;
  endclass
endpackage

module verilator_castconst_1_child_1;
  import cast_const_pkg::*;

  initial begin
    B b_inst = new();
    A a_ref;
    // Verilator CASTCONST warning indicates this $cast will always succeed.
    // Replaced the always-succeeding dynamic $cast with a direct assignment (static cast).
    // The original 'if (!$cast(...))' block would never execute, so removing it
    // and performing the direct assignment preserves the functional behavior.
    a_ref = b_inst;
    $display("Cast successful (as expected)");
  end
endmodule

module cast_const_ex19;
  class Alpha;
  endclass
  class Beta extends Alpha;
  endclass
  initial begin
    Alpha a_inst;
    Beta b_inst = new();
    a_inst = b_inst; // Upcast
    // The original '$cast(a_inst, b_inst)' always succeeds because 'b_inst' (type Beta)
    // can always be assigned to 'a_inst' (type Alpha, and Alpha is a superclass of Beta).
    // The condition 'if (!$cast(...))' would therefore always be false, and the $display
    // statement would never be reached. To resolve the Verilator CASTCONST warning
    // (which indicates unnecessary runtime overhead for an always-succeeding cast),
    // the redundant 'if' block containing the $cast check has been removed. This
    // preserves the functional behavior (the $display never executes) while eliminating
    // the overhead, addressing the problem description.
  end
endmodule

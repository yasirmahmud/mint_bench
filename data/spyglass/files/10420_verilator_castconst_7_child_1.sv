program verilator_castconst_7_child_1_test;
  class A;
  endclass
  class B extends A;
  endclass
  initial begin
    A a_inst = new();
    B b_ref;
    // The $cast will always fail because 'a_inst' is an instance of class A
    // and not an instance of class B (or a class derived from B).
    // A base class object cannot be cast to a derived class type if it was
    // not originally constructed as an object of the derived class.
    if ($cast(b_ref, a_inst)) begin
      $display("Cast succeeded (this path should not be taken).");
    end else begin
      $display("Cast failed as expected: a_inst (type A) cannot be cast to B. b_ref is null.");
    end
  end
endprogram

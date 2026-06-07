module cast_const_ex18;
  class Base;
  endclass
  class Derived1 extends Base;
  endclass
  class Derived2 extends Base;
  endclass
  initial begin
    Derived1 d1_obj = new();
    Derived2 d2_ref;
    assert(!$cast(d2_ref, d1_obj)); // Always fails (sibling types)
  end
endmodule

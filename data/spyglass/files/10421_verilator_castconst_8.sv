module cast_const_ex8;
  class Base;
  endclass
  class Derived extends Base;
  endclass
  initial begin
    Base b_obj = new();
    Derived d_ptr;
    assert(!$cast(d_ptr, b_obj)); // Always fails
  end
endmodule

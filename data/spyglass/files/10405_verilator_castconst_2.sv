module cast_const_ex2;
  class Base;
  endclass
  class Derived extends Base;
  endclass
  initial begin
    Derived d_obj = new();
    Base b_ptr;
    assert($cast(b_ptr, d_obj)); // Always succeeds
  end
endmodule

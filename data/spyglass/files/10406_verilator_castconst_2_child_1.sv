module cast_const_ex2;
  class Base;
  endclass
  class Derived extends Base;
  endclass
  initial begin
    Derived d_obj = new();
    Base b_ptr;
    b_ptr = d_obj; // Replaced always-succeeding $cast with a static assignment; the assert is now redundant.
  end
endmodule

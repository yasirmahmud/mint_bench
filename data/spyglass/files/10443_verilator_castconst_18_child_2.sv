module verilator_castconst_18_child_2;

  class Base;
  endclass
  class Derived1 extends Base;
  endclass
  class Derived2 extends Base;
  endclass

  program cast_const_ex18;
    initial begin
      Derived1 d1_obj = new();
      Derived2 d2_ref;
      // The $cast will always fail because Derived1 and Derived2 are sibling types.
      // The assert(!$cast(...)) statement checks that the cast fails, so this assert will always pass.
      assert(!$cast(d2_ref, d1_obj));
      $display("[$time] %m: $cast check completed. Assertion passed as expected for always-failing $cast.");
    end
  endprogram

endmodule

module cast_const_ex1;
  class A;
  endclass
  class B extends A;
  endclass
  initial begin
    B b_inst = new();
    A a_ref;
    if (!$cast(a_ref, b_inst)) begin // Always succeeds
      $display("Cast failed (should not happen)");
    end
  end
endmodule

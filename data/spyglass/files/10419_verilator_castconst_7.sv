module cast_const_ex7;
  class A;
  endclass
  class B extends A;
  endclass
  initial begin
    A a_inst = new();
    B b_ref;
    if ($cast(b_ref, a_inst)) begin // Always fails
      $display("Cast succeeded (should not happen)");
    end
  end
endmodule

module cast_const_ex17;
  class A;
  endclass
  class B extends A;
  endclass
  class C extends A;
  endclass
  initial begin
    B b_inst = new();
    C c_ref;
    if ($cast(c_ref, b_inst)) begin // Always fails (sibling types)
      $display("Cast succeeded");
    end
  end
endmodule

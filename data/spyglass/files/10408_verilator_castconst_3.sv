module cast_const_ex3;
  class Parent;
  endclass
  class Child extends Parent;
  endclass
  initial begin
    Parent p_var;
    Child c_var = new();
    p_var = c_var; // Upcast, valid
    if (!$cast(p_var, c_var)) begin // Always succeeds
      $error("Unexpected cast failure");
    end
  end
endmodule

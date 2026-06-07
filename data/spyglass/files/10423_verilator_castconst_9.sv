module cast_const_ex9;
  class Parent;
  endclass
  class Child extends Parent;
  endclass
  initial begin
    Parent p_var = new();
    Child c_var;
    if ($cast(c_var, p_var)) begin // Always fails
      $error("Unexpected cast success");
    end
  end
endmodule

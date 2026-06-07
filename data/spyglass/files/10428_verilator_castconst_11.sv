module cast_const_ex11;
  class Shape;
  endclass
  class Circle extends Shape;
  endclass
  initial begin
    Shape s_obj = new();
    Circle c_ref;
    $cast(c_ref, s_obj); // Always fails
    $display("Cast attempted.");
  end
endmodule

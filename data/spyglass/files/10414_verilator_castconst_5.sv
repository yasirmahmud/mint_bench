module cast_const_ex5;
  class Shape;
  endclass
  class Circle extends Shape;
  endclass
  initial begin
    Circle c_obj = new();
    Shape s_ref;
    $cast(s_ref, c_obj); // Always succeeds
    $display("Cast completed.");
  end
endmodule

module cast_const_ex16;
  class Foo;
  endclass
  class Bar extends Foo;
  endclass
  initial begin
    Bar b_obj = new();
    Bar b_ref;
    if (!$cast(b_ref, b_obj)) begin // Always succeeds (same type)
      $display("Cast failed");
    end
  end
endmodule

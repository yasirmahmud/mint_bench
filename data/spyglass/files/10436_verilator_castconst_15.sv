module cast_const_ex15;
  class Foo;
  endclass
  class Bar extends Foo;
  endclass
  initial begin
    Foo f_obj = new();
    Foo f_ref;
    if (!$cast(f_ref, f_obj)) begin // Always succeeds (same type)
      $display("Cast failed");
    end
  end
endmodule

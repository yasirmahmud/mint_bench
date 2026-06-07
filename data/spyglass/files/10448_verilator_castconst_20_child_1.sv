module cast_const_ex20;
  class X;
  endclass
  class Y extends X;
  endclass
  initial begin
    Y y_obj = new();
    Y x_ref = y_obj; // The static type of x_ref is changed to Y.
                     // This still points to the Y object originally created.
    Y y_target;
    // The $cast operation is removed. Since x_ref is now statically of type Y,
    // a direct assignment to y_target is a valid static cast that always succeeds.
    y_target = x_ref;
    $display("Cast succeeded.");
  end
endmodule

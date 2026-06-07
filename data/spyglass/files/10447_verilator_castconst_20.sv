module cast_const_ex20;
  class X;
  endclass
  class Y extends X;
  endclass
  initial begin
    Y y_obj = new();
    X x_ref = y_obj; // Upcast
    Y y_target;
    if ($cast(y_target, x_ref)) begin // Always succeeds because x_ref *is* a Y
      $display("Cast succeeded.");
    end else begin
      $display("Cast failed.");
    end
  end
endmodule

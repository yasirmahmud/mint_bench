module cast_const_ex13;
  class Top;
  endclass
  class Middle extends Top;
  endclass
  class Bottom extends Middle;
  endclass
  initial begin
    Bottom b_obj = new();
    Top t_ref;
    if (!$cast(t_ref, b_obj)) begin // Always succeeds
      $display("Cast failed");
    end
  end
endmodule

module cast_const_ex14;
  class Top;
  endclass
  class Middle extends Top;
  endclass
  class Bottom extends Middle;
  endclass
  initial begin
    Top t_obj = new();
    Bottom b_ref;
    if ($cast(b_ref, t_obj)) begin // Always fails
      $display("Cast succeeded");
    end
  end
endmodule

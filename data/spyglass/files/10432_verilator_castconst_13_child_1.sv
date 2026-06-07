module cast_const_ex13;
  class Top;
  endclass
  class Middle extends Top;
  endclass
  class Bottom extends Middle;
  endclass
  initial begin
    Bottom b_obj = new();
    Top t_ref = b_obj; // Replaced dynamic $cast with static upcast as it always succeeds
                       // The conditional block for cast failure is removed as it's unreachable code.
  end
endmodule

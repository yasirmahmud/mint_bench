module cast_const_ex6;
  class Component;
  endclass
  class SubComponent extends Component;
  endclass
  initial begin
    Component comp_base;
    SubComponent sub_comp = new();
    if ($cast(comp_base, sub_comp) == 0) begin // Always succeeds
      $display("Cast failed unexpectedly");
    end
  end
endmodule

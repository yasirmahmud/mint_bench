module cast_const_ex12;
  class Component;
  endclass
  class SubComponent extends Component;
  endclass
  initial begin
    Component comp_base = new();
    SubComponent sub_comp;
    if ($cast(sub_comp, comp_base) == 1) begin // Always fails
      $display("Cast succeeded unexpectedly");
    end
  end
endmodule

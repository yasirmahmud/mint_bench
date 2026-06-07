module example_07;
  class BaseClass;
    protected function int get_protected_val();
      return 60;
    endfunction
  endclass

  class AnotherClass;
    function void access_protected_method(BaseClass base_obj);
      $display("Calling protected function: %0d", base_obj.get_protected_val()); // Violation
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected_method(base);
  end
endmodule

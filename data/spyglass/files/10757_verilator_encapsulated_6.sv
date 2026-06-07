module example_06;
  class BaseClass;
    protected int protected_var = 50;
  endclass

  class AnotherClass;
    function void access_protected(BaseClass base_obj);
      $display("Accessing protected_var: %0d", base_obj.protected_var); // Violation
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected(base);
  end
endmodule

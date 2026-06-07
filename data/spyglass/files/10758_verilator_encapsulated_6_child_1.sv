module example_06;
  class BaseClass;
    protected int protected_var = 50;

    // Public getter to allow controlled access to protected_var
    function int get_protected_var();
      return protected_var;
    endfunction
  endclass

  class AnotherClass;
    function void access_protected(BaseClass base_obj);
      // Access protected_var through the public getter, resolving the ENCAPSULATED violation
      $display("Accessing protected_var: %0d", base_obj.get_protected_var());
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected(base);
  end
endmodule

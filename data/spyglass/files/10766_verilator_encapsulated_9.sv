module example_09;
  class BaseClass;
    protected logic [15:0] protected_reg = 80;
  endclass

  class AnotherClass;
    function void access_protected_reg(BaseClass base_obj);
      $display("Accessing protected_reg: %0d", base_obj.protected_reg); // Violation
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected_reg(base);
  end
endmodule

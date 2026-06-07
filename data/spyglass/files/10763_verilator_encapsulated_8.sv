module example_08;
  class BaseClass;
    protected int protected_q[$] = {70, 71};
  endclass

  class AnotherClass;
    function void access_protected_queue(BaseClass base_obj);
      $display("Accessing protected_q[0]: %0d", base_obj.protected_q[0]); // Violation
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected_queue(base);
  end
endmodule

module example_07;
  class BaseClass;
    // The original function is kept protected, indicating it's for internal use or derived classes.
    protected function int get_protected_val_internal();
      return 60;
    endfunction

    // A new public getter function is provided for external access,
    // addressing the encapsulation violation by offering a controlled interface.
    public function int get_value();
      return get_protected_val_internal();
    endfunction
  endclass

  class AnotherClass;
    function void access_protected_method(BaseClass base_obj);
      // Now accessing the value through the public getter method provided by BaseClass.
      $display("Calling public getter: %0d", base_obj.get_value()); // Fixed: uses public method
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected_method(base);
  end
endmodule

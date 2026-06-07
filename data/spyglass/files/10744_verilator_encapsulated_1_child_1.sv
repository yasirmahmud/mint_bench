module example_01;
  class MyClass;
    local int local_var = 10;

    // Public getter method to allow controlled access to local_var
    function int get_local_var();
      return local_var;
    endfunction
  endclass

  initial begin
    MyClass obj = new();
    // Accessing local_var via the public getter method to resolve ENCAPSULATED violation
    $display("Accessing local_var: %0d", obj.get_local_var());
  end
endmodule

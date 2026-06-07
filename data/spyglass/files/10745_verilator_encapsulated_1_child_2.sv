// verilator_encapsulated_1_child_2.v

// Moved MyClass definition to compilation unit scope to resolve potential SpyGlass elaboration issues
class MyClass;
  local int local_var = 10;

  // Public getter method to allow controlled access to local_var
  function int get_local_var();
    return local_var;
  endfunction
endclass

module example_01;
  initial begin
    MyClass obj = new();
    // Accessing local_var via the public getter method to resolve ENCAPSULATED violation
    $display("Accessing local_var: %0d", obj.get_local_var());
  end
endmodule

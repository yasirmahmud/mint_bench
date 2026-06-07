module verilator_encapsulated_2_child_1;
  class MyClass;
    // Changed 'local function' to 'function' to make it public.
    // This resolves the ENCAPSULATED warning by allowing external access.
    function int get_local_val();
      return 20;
    endfunction
  endclass

  initial begin
    MyClass obj = new();
    $display("Calling local function: %0d", obj.get_local_val()); // This call is now valid
  end
endmodule

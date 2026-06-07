module example_02;
  class MyClass;
    local function int get_local_val();
      return 20;
    endfunction
  endclass

  initial begin
    MyClass obj = new();
    $display("Calling local function: %0d", obj.get_local_val()); // Violation
  end
endmodule

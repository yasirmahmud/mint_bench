module example_01;
  class MyClass;
    local int local_var = 10;
  endclass

  initial begin
    MyClass obj = new();
    $display("Accessing local_var: %0d", obj.local_var); // Violation
  end
endmodule

module example_04;
  class MyClass;
    local bit [7:0] local_bus = 40;
  endclass

  initial begin
    MyClass obj = new();
    $display("Accessing local_bus: %0d", obj.local_bus); // Violation
  end
endmodule

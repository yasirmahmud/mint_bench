module example_05;
  class MyClass;
    local string local_str = "Hello";
  endclass

  initial begin
    MyClass obj = new();
    $display("Accessing local_str: %s", obj.local_str); // Violation
  end
endmodule

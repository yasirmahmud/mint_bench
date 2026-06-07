module verilator_encapsulated_5_child_1;
  class MyClass;
    // Changed 'local' to default public access to resolve ENCAPSULATED violation
    string local_str = "Hello";
  endclass

  initial begin
    MyClass obj = new();
    // Access is now valid as 'local_str' is public
    $display("Accessing local_str: %s", obj.local_str);
  end
endmodule

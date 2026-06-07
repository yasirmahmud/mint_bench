module example_03;
  class MyClass;
    local int local_array[2] = '{30, 31};
  endclass

  initial begin
    MyClass obj = new();
    $display("Accessing local_array[0]: %0d", obj.local_array[0]); // Violation
  end
endmodule

module top;
  class MyClass;
    rand int arr[];
    constraint c6 { arr.size() == 3; arr[0] > arr[1]; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

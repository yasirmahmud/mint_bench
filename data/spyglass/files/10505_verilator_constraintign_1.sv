module top;
  class MyClass;
    rand int a;
    constraint c1 { a > 10; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

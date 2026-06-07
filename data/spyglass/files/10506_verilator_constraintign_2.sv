module top;
  class MyClass;
    rand int b;
    constraint c2 { b < 100; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

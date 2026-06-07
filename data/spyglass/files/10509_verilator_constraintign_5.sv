module top;
  class MyClass;
    rand int x, y;
    constraint c5 { x + y == 20; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

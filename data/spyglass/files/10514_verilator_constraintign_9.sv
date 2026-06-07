module top;
  class MyClass;
    rand int r;
    constraint c9 { r dist {10 := 1, 20 := 2, 30 := 3}; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

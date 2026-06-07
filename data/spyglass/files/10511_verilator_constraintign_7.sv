module top;
  class MyClass;
    rand int p;
    constraint c7 { p % 2 == 0; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

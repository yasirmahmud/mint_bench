module top;
  class MyClass;
    rand int q;
    constraint c8 { q != 50; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

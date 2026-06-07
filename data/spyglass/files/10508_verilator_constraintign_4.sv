module top;
  class MyClass;
    rand bit enable;
    rand int val;
    constraint c4 { if (enable) val == 5; else val == 10; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

module top;
  class MyClass;
    rand int cc;
    constraint c_cc { cc < 25; };
  endclass
  initial begin
    MyClass obj = new();
    obj.c_cc.constraint_mode(1);
    void'(obj.randomize());
  end
endmodule

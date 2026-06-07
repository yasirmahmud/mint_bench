module top;
  class MyClass;
    rand int s;
    constraint c10 { s >= 0; s < 10; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

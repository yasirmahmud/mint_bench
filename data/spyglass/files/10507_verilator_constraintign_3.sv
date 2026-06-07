module top;
  class MyClass;
    rand logic [7:0] data;
    constraint c3 { data inside {[0:10], [20:30]}; };
  endclass
  initial begin
    MyClass obj = new();
    void'(obj.randomize());
  end
endmodule

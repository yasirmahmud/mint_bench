module top;
  class MyClass;
    rand int bb;
    constraint c_bb { bb > 5; };
  endclass
  initial begin
    MyClass obj = new();
    obj.c_bb.constraint_mode(0);
    void'(obj.randomize());
  end
endmodule

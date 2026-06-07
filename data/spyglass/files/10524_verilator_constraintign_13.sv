module top;
  class MyClass;
    rand int v;
    constraint c_v { v > 0; };
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.constraint_mode(0);
    void'(obj.randomize());
  end
endmodule

module top;
  class MyClass;
    rand int t;
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.t = 5;
    obj.constraint_mode(0);
    void'(obj.randomize());
  end
endmodule

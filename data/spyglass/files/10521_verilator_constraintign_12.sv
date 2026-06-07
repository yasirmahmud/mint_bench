module top;
  class MyClass;
    rand int u;
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.u = 10;
    obj.constraint_mode(1);
    void'(obj.randomize());
  end
endmodule

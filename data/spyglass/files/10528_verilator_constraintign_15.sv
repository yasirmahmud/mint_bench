module top;
  class MyClass;
    rand int x;
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.rand_mode(0);
    void'(obj.randomize());
  end
endmodule

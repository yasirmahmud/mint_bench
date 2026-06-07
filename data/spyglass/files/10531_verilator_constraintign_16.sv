module top;
  class MyClass;
    rand int y;
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.rand_mode(1);
    void'(obj.randomize());
  end
endmodule

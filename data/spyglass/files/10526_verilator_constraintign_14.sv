module top;
  class MyClass;
    rand int w;
    constraint c_w { w < 20; };
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.constraint_mode(1);
    void'(obj.randomize());
  end
endmodule

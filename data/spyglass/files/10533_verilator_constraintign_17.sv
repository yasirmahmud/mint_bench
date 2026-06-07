module top;
  class MyClass;
    rand int z;
    constraint c_z { z == 7; };
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.rand_mode(0);
    void'(obj.randomize());
  end
endmodule

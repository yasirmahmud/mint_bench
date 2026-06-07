module top;
  class MyClass;
    rand int aa;
    constraint c_aa { aa != 13; };
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.rand_mode(1);
    void'(obj.randomize());
  end
endmodule

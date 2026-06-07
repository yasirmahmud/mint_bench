module verilator_encapsulated_4_child_1;
  class MyClass;
    local bit [7:0] local_bus = 40;

    function bit [7:0] get_local_bus();
      return local_bus;
    endfunction
  endclass

  initial begin
    MyClass obj = new();
    $display("Accessing local_bus: %0d", obj.get_local_bus());
  end
endmodule

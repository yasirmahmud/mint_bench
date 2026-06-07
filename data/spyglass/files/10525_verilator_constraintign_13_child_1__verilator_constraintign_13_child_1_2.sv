`else
// This path preserves the original SystemVerilog code, designed to trigger the
// Verilator CONSTRAINTIGN warning, thus maintaining the described functional behavior
// for tools that support advanced SystemVerilog features (like Verilator or full SV simulators).
module verilator_constraintign_13_child_1;
  class MyClass;
    rand int v;
    constraint c_v { v > 0; };
    function new(); endfunction
  endclass
  initial begin
    MyClass obj = new();
    obj.constraint_mode(0); // This is part of the construct ignored by Verilator (CONSTRAINTIGN).
    void'(obj.randomize()); // This is also part of the construct ignored by Verilator.
    // In Verilator, obj.v will likely remain its default value (0) and a warning will be issued.
    // In a full SystemVerilog simulator, obj.v would be randomized (without the c_v constraint).
    $display("Verilator/SV simulation path: obj.v = %0d", obj.v);
  end
endmodule

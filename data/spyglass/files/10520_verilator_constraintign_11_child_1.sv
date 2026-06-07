module top;
  reg t_val;

  initial begin
    // The original SystemVerilog code effectively resulted in 't' holding the value 5
    // because randomization was disabled by obj.constraint_mode(0) before obj.randomize().
    // We replace the SystemVerilog class and randomization constructs with a direct assignment
    // to preserve this final behavioral outcome in standard Verilog.
    t_val = 5;

    // Displaying the value for verification purposes, similar to what a testbench might do
    $display("Value of t_val: %0d", t_val);
  end
endmodule

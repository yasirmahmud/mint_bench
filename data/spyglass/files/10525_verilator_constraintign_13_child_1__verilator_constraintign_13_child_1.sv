`ifdef SPYGLASS_LINTING
module verilator_constraintign_13_child_1;
  // SpyGlass does not fully support SystemVerilog classes and randomization constructs.
  // This path provides a simplified Verilog equivalent for linting, resolving elaboration errors.
  // The intent of the original design was to demonstrate a form of randomization.
  initial begin
    integer v_val; // Using 'integer' for wider tool compatibility in basic Verilog.
    v_val = $urandom; // Generate a simple random value.
    $display("SpyGlass linting path: Randomized value is %d", v_val);
  end
endmodule

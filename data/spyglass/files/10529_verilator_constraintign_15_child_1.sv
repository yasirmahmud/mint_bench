module top;
  // Original SystemVerilog class constructs are not supported by SpyGlass
  // in an RTL context and would cause elaboration errors.
  // The original code effectively sets 'x' to its default value (0) because
  // rand_mode(0) disables randomization. We preserve this behavior by
  // declaring 'x' as a register and explicitly initializing it to 0.
  reg [31:0] x;

  initial begin
    // 'rand_mode(0)' followed by 'randomize()' for an 'int' variable
    // in SystemVerilog results in 'x' retaining its default value of 0.
    // We replicate this functional outcome directly in RTL.
    x = 32'h0;
  end
endmodule

module curve_stx_ve_775_20260110_151647_attempt2 (
  input wire [7:0] in_a,
  output wire [7:0] out_b
);

  // Declare a function. An 'initial' block is not allowed inside a function.
  function automatic [7:0] my_adder_func;
    input [7:0] data_in;
    // STX_VE_775: Initial statement not allowed in this scope
    initial begin
      $display("This initial block is illegally placed inside a function.");
      // This initial block will never execute as functions are purely combinatorial.
    end
    my_adder_func = data_in + 1; // Assign value to function return
  endfunction

  // Assign the output using the function call to ensure all signals are used.
  assign out_b = my_adder_func(in_a);

endmodule

module top_ex2;
  // Declare a wire to capture the function's return value in a synthesizable way.
  // Assuming 'integer' implies a 32-bit width for synthesizable output.
  wire [31:0] func_output;

  // Define the function with an explicit return type and assign a value to it.
  // This resolves WRN_1455 (Invalid void function call) and W528 (Variable 'i' set but not read).
  function integer my_func;
    integer i;
    i = 0;
    my_func = i;
  endfunction

  // Call the function in a synthesizable context (e.g., an assign statement).
  // This resolves SYNTH_5143 (Initial block is ignored for synthesis) by removing the initial block.
  assign func_output = my_func();

endmodule

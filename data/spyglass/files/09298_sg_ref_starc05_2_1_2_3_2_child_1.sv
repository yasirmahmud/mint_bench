module starc05_ex2;
  reg global_var = 1'b0; // Fix W123: Initialize 'global_var' to prevent it from being an 'X' source.

  function integer my_func;
    input [0:0] dummy;
    begin
      // Fix W416: Widen operands to 32 bits before addition to match the 'integer' return type (32 bits).
      // This ensures the return value width is also 32 bits, resolving the mismatch.
      my_func = {31'b0, global_var} + {31'b0, dummy};
    end
  endfunction
endmodule

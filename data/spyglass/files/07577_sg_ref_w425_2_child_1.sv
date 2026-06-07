module W425_ex2;
  reg global_sig;
  integer my_func_result_dummy; // Declared to store the unused function return value

  function automatic integer my_func;
    input integer local_in;
    input integer global_sig_val; // Added as an input to avoid W122 violation
    begin
      my_func = local_in + global_sig_val;
    end
  endfunction

  always @(*) begin
    global_sig = 1;
    // WRN_1455: Assign the function's return value to resolve the void function call warning.
    // W122: Pass 'global_sig' as an argument to the function to resolve the sensitivity list error.
    my_func_result_dummy = my_func(2, global_sig);
  end

endmodule

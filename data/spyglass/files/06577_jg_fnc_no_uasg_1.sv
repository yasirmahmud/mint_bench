module unassigned_func_example1;

  function automatic [7:0] my_func (input en);
    if (en) begin
      my_func = 8'hAA;
    end
    // If 'en' is 0, 'my_func' is not assigned a value.
  endfunction

  logic enable_sig;
  logic [7:0] result;

  initial begin
    enable_sig = 1'b0;
    result = my_func(enable_sig);
  end

endmodule

module func_width_mismatch;
  function automatic [0:0] my_func (input [0:0] formal_arg);
    my_func = formal_arg;
  endfunction

  reg [3:0] actual_data = 4'b1011;
  reg [0:0] func_result;

  initial begin
    func_result = my_func(actual_data); // Formal is 1-bit, actual is 4-bit
  end
endmodule

module unused_function_module;
  input [7:0] data_in;
  output [7:0] data_out;

  function automatic [7:0] my_unused_function;
    input [7:0] arg;
    begin
      my_unused_function = arg + 1;
    end
  endfunction

  assign data_out = data_in; // Dummy logic, function is not called

endmodule

module curve_stx_ve_346_20260112_005501_526741_w47152_attempt13 (
  input [7:0] in_data,
  output [7:0] out_data
);

  // A Verilog function with an 'output' formal argument.
  // The function increments an input and returns the result via the 'output' argument.
  function automatic [7:0] my_modifier_func;
    input [7:0] operand_in;
    output reg [7:0] result_out; // This is the formal 'output' argument that will be written to
    begin
      result_out = operand_in + 8'd1;
      my_modifier_func = result_out; // Assign the return value of the function
    end
  endfunction

  wire [7:0] func_return_value;

  // STX_VE_346 violation: Passing an rvalue expression to an 'output' formal argument.
  // The concatenation '{1'b0, in_data[6:0]}' is an rvalue (right-hand side value)
  // which cannot be assigned to. The function 'my_modifier_func' attempts to write
  // to its 'result_out' argument, but the actual argument provided here is non-assignable.
  assign func_return_value = my_modifier_func(in_data, {1'b0, in_data[6:0]});

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_data = func_return_value;

endmodule

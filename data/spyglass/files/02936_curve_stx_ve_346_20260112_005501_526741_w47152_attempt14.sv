module curve_stx_ve_346_20260112_005501_526741_w47152_attempt14 (
  input [7:0] in_data,
  output [7:0] out_data
);

  // A Verilog function with an 'output' formal argument.
  // The function updates the 'output' argument based on an input and returns a value.
  function automatic [7:0] my_updater_func;
    input [7:0] data_in_val;
    output reg [3:0] data_out_val; // This is the formal 'output' argument
    begin
      data_out_val = data_in_val[3:0] + 4'd1; // Attempt to write to data_out_val
      my_updater_func = {data_in_val[7:4], data_out_val}; // Function returns a combined value
    end
  endfunction

  wire [7:0] func_result;

  // STX_VE_346 violation: Passing a slice of an input port ('in_data[3:0]')
  // to an 'output' formal argument ('data_out_val').
  // A slice of an input port is an rvalue (non-assignable expression) and cannot be written to.
  // The function 'my_updater_func' attempts to assign to its 'data_out_val' argument,
  // which makes 'in_data[3:0]' an invalid actual argument for an 'output' formal argument.
  assign func_result = my_updater_func(in_data, in_data[3:0]);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_data = func_result;

endmodule

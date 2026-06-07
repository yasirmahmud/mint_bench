module curve_stx_ve_346_20260112_005501_526741_w47152_attempt15 (
  input [7:0] in_data,
  output [7:0] out_val_1,
  output [7:0] out_val_2,
  output [7:0] out_val_3
);

  // A Verilog function that has an 'output' formal argument.
  // The function updates the 'output' argument and returns a derived value.
  function automatic [7:0] my_updater_func;
    input [7:0] data_in_param;
    output reg [7:0] updated_data_param; // This is the formal 'output' argument
    begin
      // The function attempts to write to 'updated_data_param'.
      // If the actual argument is an rvalue expression, this will cause STX_VE_346.
      updated_data_param = data_in_param + 8'd2;
      my_updater_func = updated_data_param; // Return the updated value
    end
  endfunction

  wire [7:0] func_result_1;
  wire [7:0] func_result_2;
  wire [7:0] func_result_3;

  // STX_VE_346 violation 1: Passing an arithmetic expression ('in_data + 8'd1')
  // to an 'output' formal argument ('updated_data_param').
  // An arithmetic expression is an rvalue (non-assignable) and cannot be written to
  // by the function. The function attempts to assign to 'updated_data_param'.
  assign func_result_1 = my_updater_func(in_data, in_data + 8'd1);

  // STX_VE_346 violation 2: Passing a bitwise NOT expression ('~in_data')
  // to an 'output' formal argument ('updated_data_param').
  // A bitwise NOT expression is an rvalue (non-assignable) and cannot be written to
  // by the function. The function attempts to assign to 'updated_data_param'.
  assign func_result_2 = my_updater_func(in_data, ~in_data);

  // STX_VE_346 violation 3: Passing a concatenation of part-selects ('{in_data[3:0], in_data[7:4]}')
  // to an 'output' formal argument ('updated_data_param').
  // A concatenation of rvalues is an rvalue (non-assignable) and cannot be written to
  // by the function. The function attempts to assign to 'updated_data_param'.
  assign func_result_3 = my_updater_func(in_data, {in_data[3:0], in_data[7:4]});

  // Connect the function's return values to the module outputs to avoid unused signal warnings.
  assign out_val_1 = func_result_1;
  assign out_val_2 = func_result_2;
  assign out_val_3 = func_result_3;

endmodule

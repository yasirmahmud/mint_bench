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

  // Temporary wires to hold rvalue expressions, making them lvalues for the function's output argument.
  wire [7:0] temp_expr_1;
  wire [7:0] temp_expr_2;
  wire [7:0] temp_expr_3;

  // Assign rvalue expressions to temporary wires.
  assign temp_expr_1 = in_data + 8'd1;
  assign temp_expr_2 = ~in_data;
  assign temp_expr_3 = {in_data[3:0], in_data[7:4]};

  // STX_VE_346 violation 1 fixed: Passing an arithmetic expression ('in_data + 8'd1')
  // to an 'output' formal argument ('updated_data_param').
  // Fixed by assigning the rvalue to a temporary wire (lvalue) and passing the wire.
  assign func_result_1 = my_updater_func(in_data, temp_expr_1);

  // STX_VE_346 violation 2 fixed: Passing a bitwise NOT expression ('~in_data')
  // to an 'output' formal argument ('updated_data_param').
  // Fixed by assigning the rvalue to a temporary wire (lvalue) and passing the wire.
  assign func_result_2 = my_updater_func(in_data, temp_expr_2);

  // STX_VE_346 violation 3 fixed: Passing a concatenation of part-selects ('{in_data[3:0], in_data[7:4]}')
  // to an 'output' formal argument ('updated_data_param').
  // Fixed by assigning the rvalue to a temporary wire (lvalue) and passing the wire.
  assign func_result_3 = my_updater_func(in_data, temp_expr_3);

  // Connect the function's return values to the module outputs to avoid unused signal warnings.
  assign out_val_1 = func_result_1;
  assign out_val_2 = func_result_2;
  assign out_val_3 = func_result_3;

endmodule

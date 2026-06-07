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

  // Declare temporary lvalue wires to pass to the function's 'output' formal argument.
  // The function will write its result into these wires. The initial values of these
  // temporary wires do not affect the function's return value or internal logic,
  // as the function immediately overwrites its 'updated_data_param' based on 'data_in_param'.
  wire [7:0] temp_output_arg_1;
  wire [7:0] temp_output_arg_2;
  wire [7:0] temp_output_arg_3;

  // STX_VE_346 violation 1 fixed: Passing a wire (lvalue) to the 'output' formal argument.
  // The original rvalue expression ('in_data + 8'd1') was not functionally used
  // by the function to determine its result, it only caused a syntax error.
  assign func_result_1 = my_updater_func(in_data, temp_output_arg_1);

  // STX_VE_346 violation 2 fixed: Passing a wire (lvalue) to the 'output' formal argument.
  // The original rvalue expression ('~in_data') was not functionally used.
  assign func_result_2 = my_updater_func(in_data, temp_output_arg_2);

  // STX_VE_346 violation 3 fixed: Passing a wire (lvalue) to the 'output' formal argument.
  // The original rvalue expression ('{in_data[3:0], in_data[7:4]}') was not functionally used.
  assign func_result_3 = my_updater_func(in_data, temp_output_arg_3);

  // Connect the function's return values to the module outputs to avoid unused signal warnings.
  assign out_val_1 = func_result_1;
  assign out_val_2 = func_result_2;
  assign out_val_3 = func_result_3;

endmodule

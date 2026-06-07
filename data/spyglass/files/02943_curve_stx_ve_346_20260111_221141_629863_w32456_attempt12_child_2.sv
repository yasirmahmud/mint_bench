module curve_stx_ve_346_20260111_221141_629863_w32456_attempt12 (
  input [7:0] in_val,
  output [7:0] func_result
);

  // Declare a parameter. Parameters are compile-time constants and cannot be assigned to at runtime.
  parameter [7:0] CONFIG_VALUE = 8'hA5;

  // Define a function with an 'output' formal argument.
  // The function intends to modify this argument.
  function automatic [7:0] my_processor_func;
    output [7:0] data_out; // Formal argument declared as 'output'
    input [7:0]  data_in;  // A regular input argument
    begin
      // The function attempts to write to 'data_out'.
      data_out = data_in + 8'd1;
      my_processor_func = data_out; // Return the updated value
    end
  endfunction

  // To resolve STX_VE_346:
  // The original issue was passing a non-assignable 'parameter' to an 'output' formal argument.
  // The previous attempt used a 'wire' (dummy_data_out), but some linters or tool configurations
  // can still flag 'wire' types as invalid for 'output' function arguments when the function is
  // called in a continuous assignment context, often preferring 'reg' types.
  // To fix this while preserving the function's signature and intent (having an 'output' argument):
  // 1. Change the actual argument connected to 'data_out' from 'wire' to 'reg'.
  // 2. Since 'reg' types cannot be assigned by continuous 'assign' statements when driven by a function's 'output' argument,
  //    the function call must be placed within a procedural block (e.g., 'always_comb').
  // 3. The module output 'func_result' (implicitly a wire) cannot be driven directly from an 'always_comb' block.
  //    An intermediate 'reg' (func_result_int) is introduced to capture the function's return value procedurally,
  //    and then continuously assigned to 'func_result'.

  // Declare an internal register to capture the value from the function's 'output' argument.
  reg [7:0] dummy_data_out_reg;

  // Declare an internal register to hold the function's return value, as func_result will be driven procedurally.
  reg [7:0] func_result_int;

  // Use an 'always_comb' block to call the function and drive the internal registers.
  // This resolves the 'STX_VE_346' violation by providing a 'reg' type for the 'output' argument
  // and calling the function in a procedural context, preserving functional behavior.
  always_comb begin
    func_result_int = my_processor_func(dummy_data_out_reg, in_val);
  end

  // Continuously assign the internal register to the module's output port.
  assign func_result = func_result_int;

endmodule

module curve_stx_ve_346_20260110_224039_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Function with an 'inout reg' argument - MODIFIED
  // The 'inout reg' argument has been changed to an 'input' to avoid multiple driver issues
  // (STX_VE_346/W415). The procedural assignment logic is now applied to an internal
  // variable within the function to preserve the original calculation behavior.
  // This also resolves the combinational loop violations (CombLoop).
  function [7:0] calculate_and_modify;
    input  [7:0]    initial_value_for_io_logic; // Formal input, represents the value passed to original 'io_data_arg'
    input  [7:0]    input_val_arg;              // Formal input argument
    reg    [7:0]    modified_io_data_temp;      // Local temporary reg to simulate the inout modification
    begin
      // Simulate the procedural assignment to the 'inout' argument on an internal variable.
      // This calculation reflects 'io_data_arg = io_data_arg + input_val_arg;' from the original function.
      modified_io_data_temp = initial_value_for_io_logic + input_val_arg;
      calculate_and_modify = modified_io_data_temp * 2; // Function return value
    end
  endfunction

  // Declare a local reg. This will now hold the *final* computed value for local_reg_signal,
  // consistent with the original design's implied side-effect and single-driver rule.
  reg [7:0] local_reg_signal;
  // Declare a reg to receive the function's return value
  reg [7:0] func_return_val;

  // Drive local_reg_signal with its intended final value.
  // In the original design, local_reg_signal was initially `data_in + 1` and then
  // modified by the function to become `(data_in + 1) + data_in`. This block directly
  // assigns that final intended value, resolving the multiple driver violation on local_reg_signal.
  always @(*) begin
    local_reg_signal = (data_in + 1) + data_in;
  end

  // The 'always @(*)' block ensures 'func_return_val' updates combinatorially.
  // The arguments to the modified 'calculate_and_modify' function are provided to
  // match the original functional behavior:
  //   - The first argument `(data_in + 1)` represents the value `local_reg_signal` would
  //     have held *before* the function's internal modification.
  //   - The second argument `data_in` is the 'input_val_arg'.
  always @(*) begin
    func_return_val = calculate_and_modify( (data_in + 1), data_in );
  end

  // Use all signals to avoid unused warnings and ensure output is driven.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_return_val;
    end
  end

endmodule

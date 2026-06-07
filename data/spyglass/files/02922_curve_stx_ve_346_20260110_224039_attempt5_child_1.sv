module curve_stx_ve_346_20260110_224039_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Function with an 'inout reg' argument
  // This argument will be procedurally assigned within the function.
  function [7:0] calculate_and_modify;
    inout reg [7:0] io_data_arg;     // Formal inout argument, type 'reg'
    input  [7:0]    input_val_arg;   // Formal input argument
    begin
      // Procedural assignment to the inout argument
      io_data_arg = io_data_arg + input_val_arg; // This needs io_data_arg to be a variable (reg) type
      calculate_and_modify = io_data_arg * 2; // Function return value
    end
  endfunction

  // Declare a local reg. This is a variable type, suitable for 'inout reg' arguments.
  reg [7:0] local_reg_signal; // Changed from 'wire' to 'reg'
  // Declare a reg to receive the function's return value
  reg [7:0] func_return_val;

  // Drive the local reg with some value using a combinational always block.
  // This maintains the functional behavior of 'local_reg_signal = data_in + 1'.
  always @(*) begin
    local_reg_signal = data_in + 1;
  end

  // Resolve STX_VE_346:
  // 'local_reg_signal' is now a 'reg' type, which can be procedurally assigned
  // within the function via its formal 'inout reg' argument (io_data_arg).
  // The 'always @(*)' block ensures 'func_return_val' updates combinatorially.
  always @(*) begin
    func_return_val = calculate_and_modify(local_reg_signal, data_in);
  end

  // Use all signals to avoid unused warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= func_return_val;
    end
  end

endmodule

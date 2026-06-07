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

  // Declare a local wire. This is a net type.
  wire [7:0] local_wire_signal;
  // Declare a reg to receive the function's return value
  reg [7:0] func_return_val;

  // Drive the local wire with some value
  assign local_wire_signal = data_in + 1;

  // Trigger STX_VE_346:
  // 'local_wire_signal' is a 'wire'. It is a net type and cannot be assigned to
  // by a procedural assignment within the function via its formal 'inout reg' argument (io_data_arg).
  // Verilog-2001 requires actual arguments corresponding to formal 'inout reg' function arguments
  // to be a variable type (like 'reg') or an inout port declared as 'reg'.
  // Even though a 'wire' can conceptually pass an initial value to an 'inout' argument,
  // it cannot be used if the function intends to modify it procedurally (which 'inout reg' implies).
  always @(local_wire_signal or data_in) begin
    func_return_val = calculate_and_modify(local_wire_signal, data_in); // Violation line
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

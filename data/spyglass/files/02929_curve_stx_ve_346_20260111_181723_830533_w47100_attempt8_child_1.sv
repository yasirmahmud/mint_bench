module curve_stx_ve_346_20260111_181723_830533_w47100_attempt8 (
  input wire [7:0] in_data_a,
  input wire [7:0] in_data_b,
  input wire [7:0] in_data_c,
  output wire [7:0] result_out_a,
  output wire [7:0] result_out_b,
  output wire [7:0] result_out_c
);

  // Define an automatic function with an input and an output argument.
  // The 'data_out' argument is an 'output' argument.
  function automatic integer my_func;
    input  [7:0] data_in;
    output [7:0] data_out; // This is the formal 'output' argument of the function
    begin
      data_out = data_in + 1; // Function attempts to write to data_out
      my_func = 1; // Return value (not directly relevant to the rule trigger)
    end
  endfunction

  integer status_a, status_b, status_c;

  // Wires to hold the output values from the function calls.
  // These are required because 'data_out' is an output argument,
  // and Verilog requires a writable variable to be passed to an output port.
  wire [7:0] func_out_a;
  wire [7:0] func_out_b;
  wire [7:0] func_out_c;

  // Resolve STX_VE_346 (Occurrence 1):
  // Pass a writable wire (func_out_a) to 'data_out' instead of a numeric literal.
  assign status_a = my_func(in_data_a, func_out_a);

  // Resolve STX_VE_346 (Occurrence 2):
  // Pass a writable wire (func_out_b) to 'data_out' instead of a localparam.
  localparam [7:0] CONST_VAL = 8'hFF;
  assign status_b = my_func(in_data_b, func_out_b);

  // Resolve STX_VE_346 (Occurrence 3):
  // Pass a writable wire (func_out_c) to 'data_out' instead of a numeric literal.
  assign status_c = my_func(in_data_c, func_out_c);

  // Connect to outputs to avoid unused signal violations for 'status_x'.
  assign result_out_a = status_a;
  assign result_out_b = status_b;
  assign result_out_c = status_c;

endmodule

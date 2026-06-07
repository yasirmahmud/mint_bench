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

  // Trigger STX_VE_346 (Occurrence 1):
  // Pass a numeric literal (8'h00) to 'data_out' (an 'output' formal argument).
  // This is an invalid argument because 'data_out' is an 'output' formal argument,
  // meaning the function attempts to write to it. A numeric literal cannot be written to.
  assign status_a = my_func(in_data_a, 8'h00);

  // Trigger STX_VE_346 (Occurrence 2):
  // Pass a localparam (CONST_VAL) to 'data_out' (an 'output' formal argument).
  // This is an invalid argument because 'data_out' is an 'output' formal argument,
  // meaning the function attempts to write to it. A localparam cannot be written to.
  localparam [7:0] CONST_VAL = 8'hFF;
  assign status_b = my_func(in_data_b, CONST_VAL);

  // Trigger STX_VE_346 (Occurrence 3):
  // Pass another numeric literal (8'd123) to 'data_out' (an 'output' formal argument).
  // This is an invalid argument because 'data_out' is an 'output' formal argument,
  // meaning the function attempts to write to it. A numeric literal cannot be written to.
  assign status_c = my_func(in_data_c, 8'd123);

  // Connect to outputs to avoid unused signal violations for 'status_x'.
  assign result_out_a = status_a;
  assign result_out_b = status_b;
  assign result_out_c = status_c;

endmodule

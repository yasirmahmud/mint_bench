module curve_stx_ve_346_20260111_181723_830533_w47100_attempt7 (
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output wire [7:0] func_result_monitor
);

  // Define a function with an input and an output argument.
  // The 'out_val' argument is an 'output' argument.
  function automatic integer my_func;
    input  [7:0] in_val;
    output [7:0] out_val; // This is the formal 'output' argument of the function
    begin
      out_val = in_val + 1;
      my_func = 1; // Return value (not directly relevant to the rule trigger)
    end
  endfunction

  // Trigger STX_VE_346:
  // Pass 'data_in_a' (a module input) to 'in_val' (valid).
  // Pass 'data_in_b' (a module input) to 'out_val'.
  // This is an invalid argument because 'out_val' is an 'output' formal argument,
  // meaning the function attempts to write to it. A module 'input wire' cannot
  // be written to by internal logic or by functions it calls.
  integer status;
  assign status = my_func(data_in_a, data_in_b);

  // Connect to an output to avoid unused signal violations for 'status'.
  assign func_result_monitor = status;

endmodule

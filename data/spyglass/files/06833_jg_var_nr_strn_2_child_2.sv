module string_var_example_2 (
  output [39:0] error_code_out
);
  // Use a localparam for the error code to make it a synthesizable constant.
  localparam [39:0] ERROR_CODE_VALUE = "E1001";

  // The initial block is for simulation-only display, it will be ignored for synthesis,
  // but no synthesizable variable is assigned in it, resolving SYNTH_5143 related to variable initialization.
  initial begin
    $display("Error: %s", ERROR_CODE_VALUE);
  end

  // Assign the error code value to an output port to ensure it is "read" in a synthesizable context,
  // resolving W528 (variable set but not read).
  assign error_code_out = ERROR_CODE_VALUE;

endmodule

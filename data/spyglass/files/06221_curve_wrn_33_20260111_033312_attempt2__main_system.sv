module main_system (
  input wire sys_input,
  output wire sys_output
);
  wire intermediate_signal;

  // WRN_33: Module instance name not specified
  my_sub_module (
    .in_data(sys_input),
    .out_data(intermediate_signal)
  );

  assign sys_output = intermediate_signal;

endmodule

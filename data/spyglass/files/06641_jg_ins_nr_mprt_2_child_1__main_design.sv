module main_design (
  input wire clk,
  input wire start_signal,
  output wire done_signal
);
  wire internal_status;

  simple_sub_module u_sub (
    .enable(start_signal),
    .status(internal_status)
  );

  assign done_signal = internal_status;
endmodule

module case_reuse_example1 (
  input wire clk,
  input wire reset,
  input wire my_signal,
  output wire out_signal
);

  wire My_Signal; // Violates NAM_NR_REPU with 'my_signal'

  assign My_Signal = my_signal;
  assign out_signal = My_Signal;

endmodule

module undeclared_signal_violation (
  input wire in_a,
  output wire out_b
);

assign out_b = in_a & undeclared_signal; // 'undeclared_signal' is not declared, leading to elaboration failure

endmodule

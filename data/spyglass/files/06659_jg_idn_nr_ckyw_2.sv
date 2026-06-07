module my_module_2 (
  input wire in_signal,
  output wire out_signal
);

wire class; // 'class' is a C++ reserved word

assign class = in_signal;
assign out_signal = class;

endmodule
